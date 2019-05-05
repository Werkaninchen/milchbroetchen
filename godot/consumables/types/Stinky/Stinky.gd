extends "res://consumables/base/Consumable.gd"

var gas_pref = load("res://consumables/types/Stinky/Gas.tscn")
var gas
func init():
	consumableType = enums.ConsumType.Stinky
	
func _ready():
	.create_timer()

func on_body_entered(body):
	.on_body_entered(body)
	if body is character:
		linkBody.is_stinky = true
		timer.start(duration)
		Sounds.play_stinky()
		gas = gas_pref.instance()
		linkBody.add_child(gas)
		return
	queue_free()
	
func on_timeout():
	if linkBody != null:
		linkBody.is_stinky = false
		linkBody.remove_child(gas)
	queue_free()