extends Node

var xp = load("res://consumables/types/XP.tscn")
var speed = load("res://consumables/types/SP.tscn")
export var consumables_amount = 5
var consumable_prefs = [xp, speed]

func _ready():
	create_consumables()

func create_consumables():
	print("danibunnyxx")
	for i in range(consumables_amount):
		var consumable = consumable_prefs[rand_range(0, consumable_prefs.size())].instance()
		consumable.position = get_rand_display_pos()
		add_child(consumable)
		
func get_rand_display_pos():
	var x = rand_range(0, ProjectSettings.get_setting("display/window/size/width"))
	var y = rand_range(0, ProjectSettings.get_setting("display/window/size/height"))
	return Vector2(x, y)