extends Control

var character_scene = preload("res://character/Character.tscn")

var player_screen = preload("res://GameView/PlayerScreen.tscn")

var start_scene = load("res://StartScreen/StartScreen.tscn")

var consumables = preload("res://consumables/Consumables.tscn")

var enemies = preload("res://Enemy/Container/EnemyContainer.tscn")

var screens = {}

var game_info

var sounds_pref = load("res://Sounds/Sounds.tscn")
var sounds 


# Called when the node enters the scene tree for the first time.
func _ready():
	sounds = sounds_pref.instance()
	add_child(sounds)
	sounds.stream = sounds.game
	sounds.play()
	
	game_info = $VBC/GameInfoPanel/GameInfoText
	
	Game.start($World, 10 * 60)
	
	Game.connect("timer_updated", self, "_on_game_timer_updated")
	
	for player in Game.players:
		var new_player_screen = player_screen.instance()
		
		screens[player] = new_player_screen
		
		new_player_screen.set_up_player_game($World, Game.players[player])
		
		
		
		
		if screens.size() <= 2:
			$VBC/HBC.add_child(new_player_screen)
		else:
			$VBC/HBC2.size_flags_vertical = SIZE_EXPAND_FILL
			$VBC/HBC2.add_child(new_player_screen)
			
	var c_container = consumables.instance()
	var e_container = enemies.instance()
	Game.world.add_child(c_container)
	Game.world.add_child(e_container)
	
	
	c_container.setup(100, Game.world_rect)
	e_container.setup(100, Game.world_rect)
		
func _input(event):
	if Game.end and event is InputEventJoypadButton:
		if !event.pressed:
			if event.button_index == JOY_START:
				Game.reset()
				SceneChanger.call_deferred("change_to_scene", start_scene.instance())
		
func setup_players(players):
	
	for player in players:
		var new_player = character_scene.instance()
		Game.players[player] = new_player
		new_player.connect("died", Game, "_on_player_died")
		Game.player_colors.shuffle()
		new_player.set_up(Game.world_rect, Game.player_colors.pop_back(), player)
		$World.add_child(new_player)
	
func _on_game_timer_updated(time):
	game_info.text = "Time till the best one wins: " + str(floor(float(time) / 60)) + ":" + str(time % 60)