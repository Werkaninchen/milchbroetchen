extends "res://consumables/base/Consumable.gd"

export var power = 2

func init():
	consumableType = enums.ConsumType.Attack
	.create_timer()

func on_body_entered(body):
	.on_body_entered(body)
	if body is character:
		linkBody.attack_power = linkBody.attack_power * power
		linkBody.sounds.stream = linkBody.sounds.power
		linkBody.sounds.play()
		timer.start(duration)
		return
	queue_free()
	
func on_timeout():
	if is_instance_valid(linkBody):
		linkBody.attack_power = linkBody.attack_power / power
		linkBody.sounds.stop()
	queue_free()