extends "res://consumables/base/Consumable.gd"
var character = load("res://character/Character.gd")

var linkBody = null
export var p_health = 10

func init_type():
	consumableType = enums.ConsumType.Health

func on_body_entered(body):
	if body is character:
		linkBody = body
		if linkBody.max_health - p_health > linkBody.current_health:
			linkBody.current_health = linkBody.current_health + p_health
		elif linkBody.max_health > linkBody.current_health:
			linkBody.current_health = linkBody.max_health
		queue_free()
	pass