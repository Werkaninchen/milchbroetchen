extends "res://consumables/base/Consumable.gd"

export var damage = 50

func init():
	consumableType = enums.ConsumType.Mine
	.create_timer()	

func on_body_entered(body):
	.on_body_entered(body)
	if body is character:
		damage_players()
		return
	queue_free()
	
func damage_players():
	for player in Game.players.values():
		var dist = self.global_position.distance_to(player.global_position)
		var current_damage = 0
		if dist < 200:
			current_damage = - damage
		elif dist < 350:
			current_damage = damage / 2
		elif dist < 500:
			current_damage = damage / 3

		if current_damage != 0:
			player.current_health -= current_damage
		linkBody.sounds.stream = linkBody.sounds.mine
		linkBody.sounds.play()
	queue_free()