extends Control

var player_game_view

var player_game_world

var player

var camera2d

var world

# Called when the node enters the scene tree for the first time.
func _ready():
	player_game_view = $MC/GameView
	player_game_world = $MC/GameView/PlayerViewport
	player_game_view.texture = player_game_world.get_texture()
	player_game_world.world_2d = world.world_2d
	camera2d.custom_viewport = player_game_world
	camera2d.current = true

func set_up_player_game(world, player):
	self.world = world
	camera2d = player.camera
	self.player = player
	
	
func _input(event):
	if event.device == player.id:
		player.joy_input(event)

