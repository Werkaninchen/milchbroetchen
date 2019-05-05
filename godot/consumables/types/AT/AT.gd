extends "res://consumables/base/Consumable.gd"

export var power = 2

func init():
	consumableType = enums.ConsumType.Attack

func _ready():
	.create_timer()

func on_body_entered(body):
	.on_body_entered(body)
	if body is character:
		linkBody.attack_power = linkBody.attack_power * power
		sounds.stream = sounds.power
		linkBody.add_child(sounds)
		sounds.play()
		timer.start(duration)
		return
	queue_free()
	
func on_timeout():
	if linkBody != null:
		linkBody.attack_power = linkBody.attack_power / power
		linkBody.remove_child(sounds)
	queue_free()