extends "res://consumables/base/Consumable.gd"
var character = load("res://character/Character.gd")

var linkBody = null
export var m_poison = 2
export var frequence = 1
export var times = 10

func init_type():
	consumableType = enums.ConsumType.Poison

func on_body_entered(body):
	if body is character:
		linkBody = body
		get_child(0).hide()
		timer.start(frequence)
	pass
	
func on_timeout():
	if times > 0:		
		linkBody.current_health = linkBody.current_health - m_poison
		times - 1
		timer.start(frequence)
	else:
	 queue_free()