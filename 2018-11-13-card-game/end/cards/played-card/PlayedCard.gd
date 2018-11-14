extends Position2D

signal opponent_played

slave var card setget set_card

func _ready():
	randomize()

remote func switch_card(card):
	emit_signal('opponent_played')
	self.card = card

func set_card(new_value):
	card = new_value
	rotation_degrees = rand_range(0, 360)
	$Sprite.texture = load(card.path)

func _on_Table_players_played():
	$Sprite.texture = null
