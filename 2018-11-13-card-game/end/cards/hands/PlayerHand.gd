extends Node2D

signal played(cards_left)
signal card_added

var cards = []

var is_turn = false setget set_is_turn
var can_play = true

func _ready():
	for card in $Cards.get_children():
		card.connect('played', self, '_on_card_played')

remote func add_card(card):
	cards.append(card)
	for card_node in $Cards.get_children():
		if not card_node.visible:
			card_node.set_card(card)
			emit_signal('card_added')
			break

func _on_card_played(card_info):
	cards.remove(cards.bsearch(card_info))
	emit_signal('played', cards.size(), card_info)
	for card in $Cards.get_children():
		card.can_play = false

remote func toggle_turn():
	self.is_turn = not is_turn

func set_is_turn(new_value):
	is_turn = new_value
	for card in $Cards.get_children():
		card.is_turn = new_value

func _on_Table_players_played():
	for card in $Cards.get_children():
		card.can_play = true
