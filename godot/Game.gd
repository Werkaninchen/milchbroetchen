extends Node

signal timer_updated(time)

signal timer_finished()

var game_start_time = 1 * 60

var game_current_time = game_start_time

var update_frame = 1

var world

var players = {}

var player_colors = [ColorN("red"), ColorN("yellow"), ColorN("green"), ColorN("blue")]

var world_rect = Rect2(0, 0, 1920, 1080)

func _ready():
	pass # Replace with function body.


func _process(delta):
	update_frame -= delta
	if update_frame <= 0:
		update_frame = 1
		emit_signal("timer_updated")
	game_current_time -= delta
	if game_current_time <= 0:
		emit_signal("timer_finished")
		set_process(false)