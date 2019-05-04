extends Area2D

var consumableType
var timer 
export var duration = 10

func _ready():
	init_type()
	connect("body_entered", self, "on_body_entered")
	create_timer()
	
func init_type():
	pass
	
func on_body_entered(body):
	pass
	
func create_timer():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.connect("timeout", self, "on_timeout")
	
func on_timeout():
	pass