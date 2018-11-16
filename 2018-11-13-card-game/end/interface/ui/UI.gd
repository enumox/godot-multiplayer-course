extends Control

func _ready():
	$PlayerName.text = GameNetwork.player_info.name
	$Score.text = str(GameNetwork.player_info.score)
	$OpponentName.text = GameNetwork.opponent_info.name

remote func set_final_text(text):
	$Instruction.text = text

func _on_Table_turn_changed(player_turn):
	var player_name = GameNetwork.player_info.name if player_turn else GameNetwork.opponent_info.name
	$Instruction.text = player_name + '\'s round'

func _on_Game_player_scored(score):
	$Score.text = str(score)

func _on_EmoteButton_pressed(emote):
	$OpponentEmote.rpc('show_emote', emote)
	$PlayerEmote.show_emote(emote)
