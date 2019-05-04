extends Control

var character_scene = preload("res://character/Character.tscn")

var player_screen = preload("res://GameView/PlayerScreen.tscn")

var players

var screens = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for player in players:
		var new_player_screen = player_screen.instance()
		if screens.size() < 2:
			$HBC/VBC.add_child(new_player_screen)
		else:
			$HBC/VBC2.add_child(new_player_screen)
		
		screens.append(new_player_screen)
		players[player].char_scene = new_player_screen

func setup_players(players):
	self.players = players
	for player in self.players:
		var new_player = character_scene.instance()
		self.players[player].char_scene = new_player
		$World.add_child(new_player)
	
