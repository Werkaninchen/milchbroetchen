extends "res://consumables/base/Consumable.gd"

export var damage = 50

func init():
	consumableType = enums.ConsumType.Mine
	.create_timer()

func on_body_entered(body):
	.on_body_entered(body)
	if body is character:
		var player = body # later for every player in the scene 
		var dist = global_position.distance_to(player.global_position)
		if dist < 100:
			player.current_health - damage
		elif dist < 300:
			player.current_health - damage / 2
		elif dist < 500:
			player.current_health - damage / 3
		queue_free()
	pass