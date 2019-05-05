extends Node

var enemy_types : Array = [preload("res://Enemy/Bacteria/Enemy.gd")]
func _ready():
	pass # Replace with function body.

func setup(amount: int , spawn_area: Rect2):
	var start : Vector2  = spawn_area.position
	var end : Vector2  = spawn_area.end
	for i in amount:
		var spawn_vector = Vector2(rand_range(start.x, end.x), rand_range(start.y, end.y))
		if spawn_area.has_point(spawn_vector):
			self.add_child(enemy_types[rand_range(0, enemy_types.size())].instance())
		

func kill_enemy(enemy_obj):
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
