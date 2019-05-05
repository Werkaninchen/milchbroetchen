extends Node

var xp = load("res://consumables/types/XP.tscn")
var sp = load("res://consumables/types/SP.tscn")
var at = load("res://consumables/types/AT.tscn")
var hl = load("res://consumables/types/HL.tscn")
var poison = load("res://consumables/types/Poison.tscn")
export var consumables_amount = 30
var consumable_prefs = [xp, sp, at, hl, poison]

func _ready():
	create_consumables()

func create_consumables():
	randomize()
	for i in range(consumables_amount):
		var consumable = consumable_prefs[rand_range(0, consumable_prefs.size())].instance()
		consumable.position = get_rand_display_pos()
		add_child(consumable)
		
func get_rand_display_pos():
	randomize()
	var x = rand_range(0, ProjectSettings.get_setting("display/window/size/width"))
	var y = rand_range(0, ProjectSettings.get_setting("display/window/size/height"))
	return Vector2(x, y)