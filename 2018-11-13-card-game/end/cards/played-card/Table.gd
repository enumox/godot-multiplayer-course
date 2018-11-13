extends Node2D

signal turn_changed(player_turn)
signal players_played
signal score_updated(player_scored)
signal game_ended

var played_cards = 0
var deck_empty = false

func _ready():
	randomize()
	if get_tree().is_network_server():
			_deal_hands()
			var server_plays = rand_range(0, 100) > 50
			if server_plays:
				$PlayerHand.rpc('toggle_turn')
			else:
				$PlayerHand.toggle_turn()
			rpc('toggle_turn')

func set_played_card(card):
	$PlayerCardPlayed.card = card
	$OpponentCardPlayed.rpc_id(GameNetwork.opponent_info.id, 'switch_card', card)

func _deal_hands():
	for i in range(6):
		var card = $Deck.draw_card()
		if card == null:
			break
		if i % 2 == 0:
			$PlayerHand.add_card(card)
		else:
			$PlayerHand.rpc('add_card', card)

func _on_PlayerHand_played(cards_left, card_played):
	$PlayerCardPlayed.card = card_played
	$OpponentCardPlayed.rpc_id(GameNetwork.opponent_info.id, 'switch_card', card_played)
	rpc('toggle_turn')
	rpc('card_played')

sync func toggle_turn():
	$PlayerHand.toggle_turn()
	emit_signal('turn_changed', $PlayerHand.is_turn)

sync func card_played():
	played_cards += 1
	if played_cards > 0 and played_cards % 2 == 0:
		$Timer.start()
		yield($Timer, 'timeout')
		emit_signal('players_played')
		var player_scored = false
		
		if $OpponentCardPlayed.card.value < $PlayerCardPlayed.card.value:
			player_scored = true
		elif $OpponentCardPlayed.card.value == $PlayerCardPlayed.card.value:
			player_scored = rand_range(0, 100) > 50
		
		
		emit_signal('score_updated', player_scored)
		if played_cards == 4 and deck_empty:
			emit_signal('game_ended')
		elif played_cards == 6:
			played_cards = 0
			if get_tree().is_network_server():
				_deal_hands()
				rpc('toggle_turn')

func _on_Deck_deck_emptied():
	deck_empty = true
