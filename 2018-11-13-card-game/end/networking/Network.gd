extends Node

func _ready():
	get_tree().connect('network_peer_disconnected', self, '_on_player_disconnected')
	get_tree().connect('network_peer_connected', self, '_on_player_connected')
	get_tree().connect('server_disconnected', self, '_on_server_disconnected')

func _on_player_disconnected(id):
	pass

func _on_player_connected(id):
	pass

func _on_connected_to_server():
	pass

func _on_server_disconnected():
	pass

func create_server(port):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(int(port), 2)
	get_tree().set_network_peer(peer)

func connect_to_server(ip, port):
	var peer = NetworkedMultiplayerENet.new()
	get_tree().connect('connected_to_server', self, '_on_connected_to_server')
	peer.create_client(ip, int(port))
	get_tree().set_network_peer(peer)
