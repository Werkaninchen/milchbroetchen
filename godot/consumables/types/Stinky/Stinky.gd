extends "res://consumables/base/Consumable.gd"

var gas_pref = load("res://consumables/types/Stinky/Gas.tscn")
var gas
func init():
	consumableType = enums.ConsumType.Stinky
	.create_timer()	

func on_body_entered(body):
	.on_body_entered(body)
	if body is character:
		linkBody.is_stinky = true
		timer.start(duration)
		linkBody.sounds.stream = linkBody.sounds.stinky
		linkBody.sounds.play()
		gas = gas_pref.instance()
		linkBody.add_child(gas)
		return
	queue_free()
	
func on_timeout():
	if linkBody != null:
		linkBody.is_stinky = false
		linkBody.remove_child(gas)
		linkBody.sounds.stop()
	queue_free()