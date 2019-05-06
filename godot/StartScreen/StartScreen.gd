extends Control

var screen_scene = preload("res://GameView/Screen.tscn")

var p1 = {}
var p2 = {}
var p3 = {}
var p4 = {}
var players = {}
var timer
var info
var player_texts = []

func _ready():
	randomize()
	
	player_texts.append($VBC/HBC/Player1)
	
	player_texts.append($VBC/HBC/Player2)

	player_texts.append($VBC/HBC2/Player3)
	
	player_texts.append($VBC/HBC2/Player4)
	
	
	
	
	info = $VBC/Info
	
	timer = $Timer
	
	timer.connect("timeout", self, "_on_timer_timeout")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if timer.time_left == 0:
		info.text = "Last Bacteria standing."
	else:
		info.text = "Game starts in " + str(ceil(timer.time_left)) + " Seconds."



func _input(event):
	if event is InputEventJoypadButton:
		if event.pressed and !event.is_echo():
			if event.button_index == JOY_START:
				if players.has(event.device):
					players[event.device].label.text = "Please Press Start"
					players[event.device].label.get_child(0).color = ColorN("black", 0.5)
					player_texts.push_front(players[event.device].label)
					Game.player_colors.append(players[event.device].color)
					players.erase(event.device)
				else:
					players[event.device] = {}
					players[event.device].label = player_texts.pop_front()
					players[event.device].ready = false
					players[event.device].exit = false
					Game.player_colors.shuffle()
					players[event.device].color = Game.player_colors.pop_back()
					players[event.device].label.get_child(0).color = Color(players[event.device].color)
					players[event.device].label.text = "Please Hold A"
		
		if !event.pressed:
			if event.button_index == JOY_XBOX_A:
				if players.has(event.device) and players[event.device].ready == true:
					players[event.device].ready = false
					players[event.device].label.text = "Please Hold A"
					
					timer.stop()
			
			if event.button_index == JOY_SELECT:
				if players.has(event.device) and players[event.device].exit == true:
					players[event.device].exit = false
					players[event.device].label.text = "Please Hold A"
					
					
				
		if event.pressed:
			if event.button_index == JOY_XBOX_A and players.has(event.device):
				if !players[event.device].exit:
					players[event.device].ready = true
					players[event.device].label.text = "You Are Ready"
					
					var players_ready = 0
					
					for player in players:
						if players[player].ready:
							players_ready += 1
						
					if players_ready == players.size():
						timer.start(1)
			
			if event.button_index == JOY_SELECT and players.has(event.device):
				if !players[event.device].ready:
					players[event.device].exit = true
					players[event.device].label.text = "I want to go"
					
					var players_exit = 0
					
					for player in players:
						if players[player].exit:
							players_exit += 1
					
					if players_exit == players.size():
						get_tree().quit()
			
			if event.button_index == JOY_SELECT and players.empty():
				get_tree().quit()
				
func _on_timer_timeout():
	var screen = screen_scene.instance()
	screen.setup_players(players)
	SceneChanger.call_deferred("change_to_scene", screen)