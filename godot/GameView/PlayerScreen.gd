extends Control

var player_game_view

var player_game_world

var player

var camera2d

# Called when the node enters the scene tree for the first time.
func _ready():
	player_game_view = $GameView

func set_up_player_game(world, camera, player):
	player_game_world = world
	player_game_view.texture = world.get_texture()
	camera2d = camera
	camera.custom_viewport = player_game_world
	camera.current = true
	self.player = player

