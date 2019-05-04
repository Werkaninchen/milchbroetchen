extends Node

var consumables = []
var consumables_amount = 5
var consumable_prefs = [
	load("res://consumables/XP.tscn"),
	load("res://consumables/Speed.tscn")
	]

func _ready():
	self.consumables = create_consumables()

func create_consumables():
	for i in range(consumables_amount):
		var consumable = consumable_prefs[rand_range(0, consumable_prefs.size())].instance()
		consumable.position = get_rand_display_pos()
		self.consumables.append(consumable)
		
func get_rand_display_pos():
	var x = ProjectSettings.get_setting("display/window/size/width")
	var y = ProjectSettings.get_setting("display/window/size/height")
	return x, y