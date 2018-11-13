extends TextureRect

export var OPPONENT = false

var emotes = {
	'angry': preload('res://interface/emotes/emote_faceAngry.png'),
	'happy': preload('res://interface/emotes/emote_faceHappy.png'),
	'sad': preload('res://interface/emotes/emote_faceSad.png'),
	'laugh': preload('res://interface/emotes/emote_laugh.png')
}

func _ready():
	if OPPONENT:
		set_network_master(GameNetwork.opponent_info.id)
	print('network master: ' + str(get_network_master()))

remote func show_emote(emote):
	texture = emotes[emote]
	show()
	$Timer.start()

func _on_Timer_timeout():
	hide()
