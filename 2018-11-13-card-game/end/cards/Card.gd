extends Position2D

const OFFSET = 25

signal played(info)

var mouse_over = false

var is_turn = false setget set_is_turn
var can_play = true

var card_info = {
	'path': '',
	'value': ''
}

func _ready():
	set_as_toplevel(true)

func _process(delta):
	if can_play and mouse_over and Input.is_action_just_pressed('select_card'):
		hide()
		emit_signal('played', card_info)
		set_process(false)
		can_play = false

func set_is_turn(new_value):
	is_turn = new_value
	set_process(is_turn)

func _on_Area2D_mouse_entered():
	position.y -= 25
	mouse_over = true

func _on_Area2D_mouse_exited():
	position.y += 25
	mouse_over = false

remote func set_card(info):
	card_info = info
	$Area2D/Sprite.texture = load(info.path)
	show()
	visible = true
