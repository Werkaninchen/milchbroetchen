extends Area2D

var character = load("res://character/Character.gd")
var sounds_pref = load("res://Sounds/Sounds.tscn")
var sounds
var consumableType
var linkBody = null
var timer 
export var duration = 10

func _ready():
	init()
	sounds = sounds_pref.instance()
	get_tree().root.add_child(sounds)
	connect("body_entered", self, "on_body_entered")
	sounds.connect("finished", self, "on_finished")
func init():
	pass
	
func on_body_entered(body):
	if body is character:
		linkBody = body
		hide()
	
func create_timer():
	timer = Timer.new()
	add_child(timer)
	timer.set_one_shot(true)
	timer.connect("timeout", self, "on_timeout")
	
func on_timeout():
	pass
	
func on_finished():
	sounds.queue_free()