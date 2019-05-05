extends Node

var xp = load("res://consumables/types/XP/XP.tscn")
var sp = load("res://consumables/types/SP/SP.tscn")
var at = load("res://consumables/types/AT/AT.tscn")
var hl = load("res://consumables/types/HL/HL.tscn")
var poison = load("res://consumables/types/Poison/Poison.tscn")
var mine = load("res://consumables/types/Mine/Mine.tscn")
var stinky = load("res://consumables/types/Stinky/Stinky.tscn")
var consumable_prefs = [xp, sp, at, hl, poison, mine, stinky]
export var consumables_amount = 0
export var consumables_size = 1
export var rect = Rect2(0, 0, 1920, 1080)

func _ready():
	randomize()
	create_consumables()
	
func setup(amount, size, rect):
	consumables_amount = amount
	consumables_size = size
	self.rect = rect

func create_consumables():
	for i in range(consumables_amount):
		var consumable = consumable_prefs[rand_range(0, consumable_prefs.size())].instance()
		consumable.position = get_rand_display_pos()
		add_child(consumable)
		
func get_rand_display_pos():
	var x = rand_range(rect.position.x, rect.end.x)
	var y = rand_range(rect.position.y, rect.end.y)
	return Vector2(x, y)