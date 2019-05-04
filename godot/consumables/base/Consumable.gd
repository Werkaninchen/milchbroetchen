extends Area2D

var consumableType
const duration = 10

func _ready():
	init_type()
	connect("body_entered", self, "on_body_entered")
	
func init_type():
	pass
	
func on_body_entered(body):
	pass
	
func terminate():
	pass