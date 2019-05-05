extends "res://consumables/base/Consumable.gd"

export var power = 2

func init():
	consumableType = enums.ConsumType.Attack
	.create_timer()

func on_body_entered(body):
	.on_body_entered(body)
	if body is character:
		linkBody.attack_power = linkBody.attack_power * power
		timer.start(duration)
	pass
	
func on_timeout():
	linkBody.attack_power = linkBody.attack_power / power
	queue_free()