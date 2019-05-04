extends "res://consumables/base/Consumable.gd"
var character = load("res://character/Character.gd")

var timer = Timer
var linkBody = null

func init_type():
	consumableType = enums.ConsumType.Speed

func on_body_entered(body):
	if body is character:
		linkBody = body
		linkBody.max_speed = linkBody.max_speed * 2
		linkBody.add_child(self)
		connect("timeout", self, "terminate")
		timer.start(-duration)
	pass
	
func terminate():
	linkBody.max_speed = linkBody.max_speed / 2
	queue_free()