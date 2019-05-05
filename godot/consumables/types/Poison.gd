extends "res://consumables/base/Consumable.gd"

export var damage = 2
export var frequence = 1
export var times = 10

func init():
	consumableType = enums.ConsumType.Poison
	.create_timer()

func on_body_entered(body):
	.on_body_entered(body)
	if body is character:
		timer.start(frequence)
	pass
	
func on_timeout():
	if times > 0:		
		linkBody.current_health = linkBody.current_health - damage
		times - 1
		timer.start(frequence)
	else:
	 queue_free()