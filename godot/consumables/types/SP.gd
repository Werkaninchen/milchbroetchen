extends "res://consumables/base/Consumable.gd"

export var speed_up = 2
export var acc_up = 2
export var decc_up = 2
export var mass_up = 2

func init():
	consumableType = enums.ConsumType.Speed
	.create_timer()

func on_body_entered(body):
	.on_body_entered(body)
	if body is character:
		incr_speed()
		timer.start(duration)
	
func on_timeout():
	decr_speed()
	queue_free()

func incr_speed():
	linkBody.max_speed = linkBody.max_speed * speed_up
	linkBody.acc = linkBody.acc * acc_up
	linkBody.decc = linkBody.decc * decc_up
	linkBody.mass = linkBody.mass / mass_up

func decr_speed():
	linkBody.max_speed = linkBody.max_speed / speed_up
	linkBody.acc = linkBody.acc / acc_up
	linkBody.decc = linkBody.decc / decc_up
	linkBody.mass = linkBody.mass * mass_up