extends "res://consumables/base/Consumable.gd"
var character = load("res://character/Character.gd")

var linkBody = null
export var m_attack = 2

func init_type():
	consumableType = enums.ConsumType.Attack

func on_body_entered(body):
	print("body entered")
	if body is character:
		print("is character")
		linkBody = body
		linkBody.attack_power = linkBody.attack_power * m_attack
		get_child(0).hide()
		timer.start(duration)
	pass
	
func on_timeout():
	print("on timeout")
	linkBody.attack_power = linkBody.attack_power / m_attack
	queue_free()