extends Control

var character_scene = preload("res://character/Character.tscn")

var player_screen = preload("res://GameView/PlayerScreen.tscn")

var screens = {}

var game_info


# Called when the node enters the scene tree for the first time.
func _ready():
	game_info = $VBC/GameInfoPanel/GameInfoText
	
	Game.start($world, 2 * 60)
	
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
		
		

func setup_players(players):
	
	for player in players:
		var new_player = character_scene.instance()
		Game.players[player] = new_player
		new_player.connect("died", Game, "_on_player_died")
		Game.player_colors.shuffle()
		new_player.set_up(Game.world_rect, Game.player_colors.pop_back(), player)
		$World.add_child(new_player)
	
func _on_game_timer_updated(time):
	game_info.text = "Time till the best one wins: " + str(ceil(float(time) / 60)) + ":" + str(time % 60)