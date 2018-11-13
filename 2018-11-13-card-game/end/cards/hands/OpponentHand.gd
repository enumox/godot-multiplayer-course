extends Node2D

func _ready():
	randomize()

func _on_OpponentCardPlayed_opponent_played():
	while true:
		var card = $Cards.get_child(rand_range(0, $Cards.get_children().size()))
		if card.visible:
			card.hide()
			break

func _on_PlayerHand_card_added():
	for card in $Cards.get_children():
		if not card.visible:
			card.show()
			break;
