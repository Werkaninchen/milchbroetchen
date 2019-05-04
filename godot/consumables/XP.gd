extends "res://consumables/Consumable.gd"
var character = load("res://character/Character.gd")

var timer = Timer
var linkBody = null

func init_type():
	consumableType = enums.ConsumType.XP

func on_body_entered(body):
	if body is character:
		linkBody = body
		linkBody.current_exp = linkBody.current_exp * 2
		linkBody.add_child(self)
		connect("timeout", self, "terminate")
		timer.start(-duration)
	pass
	
func terminate():
	linkBody.current_exp = linkBody.current_exp / 2
	queue_free()