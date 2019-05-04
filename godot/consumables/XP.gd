extends "res://consumables/Consumable.gd"
var character = load("res://character/Character.gd")

func init_type():
	consumableType = enums.ConsumType.XP

func on_body_entered(body):
	if body is character:
		body.current_exp = body.max_speed * 2
		body.add_child(self)
	pass