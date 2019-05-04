extends "res://consumables/base/Consumable.gd"
var character = load("res://character/Character.gd")

var linkBody = null
export var m_speed = 2
export var m_acc = 2
export var m_decc = 2
export var m_mass = 2

func init_type():
	consumableType = enums.ConsumType.Speed

func on_body_entered(body):
	if body is character:
		linkBody = body
		linkBody.max_speed = linkBody.max_speed * m_speed
		linkBody.acc = linkBody.acc * m_acc
		linkBody.decc = linkBody.decc * m_decc
		linkBody.mass = linkBody.mass / m_mass
		get_child(0).hide()
		timer.start(duration)
	pass
	
func on_timeout():
	linkBody.max_speed = linkBody.max_speed / m_speed
	linkBody.acc = linkBody.acc / m_acc
	linkBody.decc = linkBody.decc / m_decc
	linkBody.mass = linkBody.mass * m_mass
	queue_free()