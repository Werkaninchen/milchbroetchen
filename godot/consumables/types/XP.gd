extends "res://consumables/base/Consumable.gd"
var character = load("res://character/Character.gd")

var linkBody = null

func init_type():
	consumableType = enums.ConsumType.XP

func on_body_entered(body):
	if body is character:
		linkBody = body
		linkBody.current_exp = linkBody.current_exp * 2
		get_child(0).hide()
		timer.start(duration)
	pass
	
func on_timeout():
	linkBody.current_exp = linkBody.current_exp / 2
	queue_free()