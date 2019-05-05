extends Node

var xp = load("res://consumables/types/XP.tscn")
var sp = load("res://consumables/types/SP.tscn")
var at = load("res://consumables/types/AT.tscn")
var hl = load("res://consumables/types/HL.tscn")
var poison = load("res://consumables/types/Poison.tscn")
var consumable_prefs = [xp, sp, at, hl, poison]
export var consumables_amount = 30
export var consumables_size = 1
export var map_width = 1920
export var map_height = 1080

func _ready():
	randomize()
	create_consumables()
	
func setup(amount, size, width, height):
	consumables_amount = amount
	consumables_size = size
	map_width = width
	map_height = height

func create_consumables():
	for i in range(consumables_amount):
		var consumable = consumable_prefs[rand_range(0, consumable_prefs.size())].instance()
		consumable.position = get_rand_display_pos()
		consumable.size = consumables_size
		add_child(consumable)
		
func get_rand_display_pos():
	var x = rand_range(0, map_width)
	var y = rand_range(0, map_height)
	return Vector2(x, y)