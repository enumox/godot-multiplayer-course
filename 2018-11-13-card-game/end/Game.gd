extends Node

var player_score = 0
var opponent_score = 0

signal player_scored(score)

func _ready():
	GameNetwork.connect('player_disconnected', self, '_on_player_disconnected')

func _on_player_disconnected():
	print('player disconnected')
	get_tree().change_scene('res://interface/StartMenu.tscn')

func _on_Table_score_updated(player_scored):
	if player_scored:
		player_score += 1
		emit_signal('player_scored', player_score)
	else:
		opponent_score += 1

func _on_Table_game_ended():
	if opponent_score > player_score:
		$UI.set_final_text('You Lose!')
		$UI.rpc('set_final_text', 'You Won!')
	else:
		$UI.set_final_text('You Won!')
		$UI.rpc('set_final_text', 'You Lose!')
	rpc('end_game')

sync func end_game():
	$Timer.start()
	yield($Timer, 'timeout')
	get_tree().change_scene('res://interface/StartMenu.tscn')
