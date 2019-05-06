extends "res://consumables/base/Consumable.gd"

export var damage = 3
export var frequence = 1
export var times = 10

func init():
	consumableType = enums.ConsumType.Poison
	.create_timer()	

func on_body_entered(body):
	.on_body_entered(body)
	if body is character:
		timer.start(frequence)
		var randau = int(rand_range(0, linkBody.sounds.poison.size()))
		print(randau)
		linkBody.sounds.stream = linkBody.sounds.poison[randau]
		linkBody.sounds.play()
		return
	queue_free()
	
func on_timeout():
	if linkBody != null:
		if times > 0:		
			linkBody.current_health - damage
			times -= 1
			timer.start(frequence)
			return
	queue_free()