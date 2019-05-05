extends Area2D
var character = load("res://character/Character.gd")

var consumableType
var linkBody = null
var timer 
export var duration = 10

func _ready():
	init()
	connect("body_entered", self, "on_body_entered")
	
func init():
	pass
	
func on_body_entered(body):
	if body is character:
		linkBody = body
		get_child(0).hide()
	
func create_timer():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.connect("timeout", self, "on_timeout")
	
func on_timeout():
	pass