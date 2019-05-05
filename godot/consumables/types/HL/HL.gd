extends "res://consumables/base/Consumable.gd"

export var health_up = 10

func init():
	consumableType = enums.ConsumType.Health

func on_body_entered(body):
	.on_body_entered(body)
	if body is character:
		if linkBody.max_health - health_up > linkBody.current_health:
			linkBody.current_health = linkBody.current_health + health_up
		elif linkBody.max_health > linkBody.current_health:
			linkBody.current_health = linkBody.max_health
		Sounds.play_health()
	queue_free()