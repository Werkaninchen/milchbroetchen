extends "res://consumables/base/Consumable.gd"

export var damage = 3
export var frequence = 1
export var times = 10

func init():
	consumableType = enums.ConsumType.Poison
	
func _ready():
	.create_timer()

func on_body_entered(body):
	.on_body_entered(body)
	if body is character:
		timer.start(frequence)
	
func on_timeout():
	if linkBody != null:
		if times > 0:		
			linkBody.current_health - damage
			Sounds.play_dot()
			times -= 1
			timer.start(frequence)
			return
	queue_free()