extends "res://consumables/base/Consumable.gd"

func init():
	consumableType = enums.ConsumType.Stinky
	
func _ready():
	.create_timer()

func on_body_entered(body):
	.on_body_entered(body)
	if body is character:
		linkBody.is_stinky = true
		timer.start(duration)
	queue_free()
	
func on_timeout():
	if linkBody != null:
		linkBody.is_stinky = false
	queue_free()