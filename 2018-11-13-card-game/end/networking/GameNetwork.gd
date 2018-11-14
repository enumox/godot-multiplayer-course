extends 'res://networking/Network.gd'

var player_info = { 
	name = '',
	score = 0,
	id = 0
}

var opponent_info = { 
	name = '', 
	score = 0,
	id = 0
}

signal player_disconnected
signal server_disconnected
signal player_connected(nickname)
signal all_information_received

func _on_player_disconnected(id):
	._on_player_disconnected(id)
	emit_signal('player_disconnected')

func _on_player_connected(id):
	._on_player_connected(id)

func _on_server_disconnected():
	._on_server_disconnected()
	emit_signal('server_disconnected')

remote func _send_player_information(info):
	opponent_info = info
	if get_tree().get_network_unique_id() == 1:
		rpc('_send_player_information', player_info)
	emit_signal('all_information_received')

func _on_connected_to_server():
	._on_connected_to_server()
	rpc('_send_player_information', player_info)

func connect_to_server(ip, port, nickname):
	.connect_to_server(ip, port)
	player_info.name = nickname
	player_info.id = get_tree().get_network_unique_id()

func create_server(port, nickname):
	.create_server(port)
	player_info.name = nickname
	player_info.id = get_tree().get_network_unique_id()
