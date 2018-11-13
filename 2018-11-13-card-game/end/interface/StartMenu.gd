extends Control

onready var JoinButton = $CenterContainer/VBoxContainer/Buttons/JoinButton
onready var HostButton = $CenterContainer/VBoxContainer/Buttons/HostButton

var ip = ''
var port = ''
var nick_name = ''

func _ready():
	_validate_menu()
	GameNetwork.connect('all_information_received', self, '_on_all_info_received')

func _on_all_info_received():
	get_tree().change_scene('res://Game.tscn')

func _on_JoinButton_pressed():
	GameNetwork.connect_to_server(ip, port, nick_name)

func _on_HostButton_pressed():
	GameNetwork.create_server(port, nick_name)

func _on_IpEdit_text_changed(new_text):
	ip = new_text
	_validate_menu()

func _on_PortEdit_text_changed(new_text):
	port = new_text
	_validate_menu()

func _on_NameEdit_text_changed(new_text):
	nick_name = new_text
	_validate_menu()

func _validate_menu():
	var nick_invalid = nick_name.length() < 4
	var ip_invalid = ip.length() < 6
	var port_invalid = port.length() < 4
	
	JoinButton.disabled = nick_invalid or ip_invalid or port_invalid
	HostButton.disabled = nick_invalid or port_invalid

func _on_ClientButton_pressed():
	GameNetwork.connect_to_server('127.0.0.1', 1313, 'Client')

func _on_ServerButton_pressed():
	GameNetwork.create_server(1313, 'Server')
