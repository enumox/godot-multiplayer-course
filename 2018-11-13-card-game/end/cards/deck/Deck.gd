extends Node2D

var cards = []
var added_cards = []

signal deck_emptied

func _ready():
	randomize()
	if get_tree().is_network_server():
		initialize_cards()

func draw_card():
	if cards.size() == 1:
		emit_signal('deck_emptied')
	return cards.pop_back()

func initialize_cards():
	for c in range(10):
		cards.append(_generate_new_card())

func _generate_new_card():
	var card = ''
	while true:
		var suit = int(rand_range(1, 5))
		var value = int(rand_range(1, 14))
		card = { 'path': _get_card_selector(suit, value), 'value': value }
		if not added_cards.has(card.path):
			added_cards.append(card.path)
			print(card.path)
			return card

func _get_card_selector(suit, value):
	var selector = 'cards/card'
	match suit:
		1:
			selector += 'Clubs'
		2:
			selector += 'Diamonds'
		3:
			selector += 'Hearts'
		4:
			selector += 'Spades'
	match value:
		1, 2, 3, 4, 5, 6, 7, 8, 9:
			selector += str(value + 1)
		10:
			selector += 'J'
		11:
			selector += 'Q'
		12:
			selector += 'K'
		13:
			selector += 'A'
	selector += '.png'
	return selector
