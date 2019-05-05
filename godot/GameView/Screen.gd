extends Control

var character_scene = preload("res://character/Character.tscn")

var player_screen = preload("res://GameView/PlayerScreen.tscn")

var players

var screens = []


# Called when the node enters the scene tree for the first time.
func _ready():
	for player in players:
		var new_player_screen = player_screen.instance()
		
		screens.append(new_player_screen)
		players[player].player_screen_scene = new_player_screen
		new_player_screen.set_up_player_game($World, players[player].char_scene.camera, players[player].char_scene)
		
		
		if screens.size() < 2:
			$VBC/HBC.add_child(new_player_screen)
		else:
			$VBC/HBC2.size_flags_vertical = SIZE_EXPAND_FILL
			$VBC/HBC2.add_child(new_player_screen)
		
		

func setup_players(players):
	self.players = players
	for player in self.players:
		var new_player = character_scene.instance()
		self.players[player].char_scene = new_player
		new_player.id = player
		$World.add_child(new_player)
	
