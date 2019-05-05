extends "res://consumables/base/Consumable.gd"

export var exp_up = 500

func init():
	consumableType = enums.ConsumType.XP

func on_body_entered(body):
	.on_body_entered(body)
	if body is character:
		linkBody.current_exp = linkBody.current_exp + exp_up
		queue_free()
	pass