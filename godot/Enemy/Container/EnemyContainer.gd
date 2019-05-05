extends Node
var enemy_types : Array = [preload("res://Enemy/Bacteria/Enemy.tscn")]

func _ready():
	setup(0, Game.world_rect)

func setup(amount: int , spawn_area: Rect2):
	var start : Vector2  = spawn_area.position
	var end : Vector2  = spawn_area.end
	for i in amount:
		var spawn_vector = Vector2(rand_range(start.x, end.x), rand_range(start.y, end.y))
		if spawn_area.has_point(spawn_vector):
			var enemy = enemy_types[rand_range(0, enemy_types.size())].instance()
			enemy.global_position = spawn_vector
			self.add_child(enemy)
		
