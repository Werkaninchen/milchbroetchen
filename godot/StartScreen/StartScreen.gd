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
		if !event.pressed:
			if event.button_index == JOY_START:
				if players.has(event.device):
					players[event.device].text.text = "Please Press Start"
					players.erase(event.device)
				else:
					players[event.device] = {}
					players[event.device].text = 
					players[event.device].text.text = "Please Hold A"
			
			if event.button_index == JOY_XBOX_A:
				if players.has(event.device) and players[event.device].ready == true:
					players[event.device].ready = false
					players[event.device].text.text = "Please Hold A"
					for player in players:
						if players[player].ready == true:
							return
					timer.stop()
					
				
		if event.pressed and event.button_index == JOY_XBOX_A:
			if players.has(event.device):
				players[event.device].ready = true
				players[event.device].text.text = "You Are Ready"
				for player in players:
					if players[player].ready and player != event.device:
				timer.start(5)
				
func _on_timer_timeout():
	var screen = screen_scene.instance()
	screen.setup_players(players)
	SceneChanger.call_deferred("change_to_scene", screen)