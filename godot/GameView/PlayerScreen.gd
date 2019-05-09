extends Control

var player_game_view

var player_game_world

var player

var camera2d

var world

var get_player = preload("res://GameView/GetPlayer.tscn")

var get_player_scenes = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("died", self, "_on_player_died")
	player.connect("won", self, "_on_player_won")
	player.connect("lost", self, "_on_player_lost")
	
	
	player_game_view = $MC/GameView
	player_game_view.connect("resized", self, "_on_view_resized")
	player_game_world = $MC/GameView/PlayerViewport
	player_game_view.texture = player_game_world.get_texture()
	player_game_world.world_2d = world.world_2d
	camera2d.custom_viewport = player_game_world
	camera2d.current = true
	
	for player in Game.players:
		if Game.players[player] != self.player:
			get_player_scenes[player] = get_player.instance()
			get_player_scenes[player].modulate = Game.players[player].color
			player_game_view.add_child(get_player_scenes[player])
			Game.players[player].connect("died", self, "_on_enemy_player_died")

func set_up_player_game(world, player):
	self.world = world
	camera2d = player.camera
	self.player = player

func _process(delta):
	for player in Game.players:
		if is_instance_valid(Game.players[player]) and Game.players[player] != self.player:
			var distance_vector = (Game.players[player].global_position - self.player.global_position)
			get_player_scenes[player].rotation = distance_vector.angle()
			get_player_scenes[player].get_child(0).scale.x = min(500 / min(distance_vector.length(), 2000), 1) * 3
			get_player_scenes[player].get_child(0).scale.y = min(500 / min(distance_vector.length(), 2000), 1) * 3
	
func _input(event):
	if event.device == player.id:
		if $MC/CharacterHud.joy_input(event):
			return 
		player.joy_input(event)
		
func _on_player_died(id):
	$MC/DeadScreen.visible = true
	for get_player_scene in get_player_scenes.values():
		get_player_scene.call_deferred("free")
	set_process_input(false)
	set_process(false)
	
func _on_enemy_player_died(id):
	get_player_scenes[id].call_deferred("free")
	
func _on_player_won(id):
	$MC/WinScreen.visible = true
	
func _on_player_lost(id):
	$MC/LostScreen.visible = true

func _on_view_resized():
	for player in Game.players:
		if Game.players[player] != self.player:
			get_player_scenes[player].global_position = rect_position + rect_size / 2
			get_player_scenes[player].get_child(0).position.x = min(rect_size.x / 2, rect_size.y / 2) - 200
		
		
		
		
		
		