extends "res://consumables/base/Consumable.gd"

export var damage = 50

func init():
	consumableType = enums.ConsumType.Mine
	
func _ready():
	.create_timer()

func on_body_entered(body):
	.on_body_entered(body)
	if body is character:
		damage_players()
	queue_free()
	
func damage_players():
	for player in Game.players.values():
		var dist = self.global_position.distance_to(player.global_position)
		print(dist)
		if dist < 200:
			player.hit(damage)
		elif dist < 350:
			player.hit(damage/2)
		elif dist < 500:
			player.hit(damage/3)