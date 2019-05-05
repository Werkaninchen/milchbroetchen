extends Node

signal timer_updated(time)

signal timer_finished()

var game_start_time = 1 * 60

var game_current_time = game_start_time

var update_frame = 1

var world

var end = false

var players = {}

var player_colors = [ColorN("red"), ColorN("yellow"), ColorN("green"), ColorN("blue")]

var world_rect = Rect2(0, 0, 500, 500)

func _ready():	
	set_process(false)
	connect("timer_finished", self, "_on_timer_finished")
	pass # Replace with function body.
	
func start(world, start_time):
	self.world = world
	game_start_time = start_time
	game_current_time = game_start_time
	emit_signal("timer_updated", int(game_current_time))
	set_process(true)

func reset():
	world = null
	players.clear()
	end = false
	game_start_time = 1 * 60
	game_current_time = game_start_time

func _process(delta):
	if game_current_time <= 0:
		emit_signal("timer_finished")
		set_process(false)
		
	update_frame -= delta
	
	if update_frame <= 0:
		update_frame = 1
		emit_signal("timer_updated", int(game_current_time))
	game_current_time -= delta

func _on_timer_finished():
	var best_xp = 0
	var best_player
	for player in players:
		if players[player].current_exp >= best_xp:
			best_xp = players[player].current_exp
	for player in players:
		if players[player].current_exp == best_xp:
			players[player].emit_signal("won", player)
		else:
			players[player].emit_signal("lost", player)
	end = true
	set_process(false)
		
	
func _on_player_died(id):
	players.erase(id)
	if players.size() <= 1:
		for player in players:
			players[player].emit_signal("won", player)
			end = true
		set_process(false)

	