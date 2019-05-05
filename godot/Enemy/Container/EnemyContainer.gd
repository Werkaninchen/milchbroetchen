extends Node

export var spawn_distance_limit = 400
var enemy_types : Array = [preload("res://Enemy/Bacteria/Enemy.tscn")]

func _ready():
	setup(50, Game.world_rect)

func setup(amount: int , spawn_area: Rect2):
	var start : Vector2  = spawn_area.position
	var end : Vector2  = spawn_area.end
	var players = Game.players
	for i in amount:
		var spawn_vector = _get_random_point(start, end, players)
		if spawn_area.has_point(spawn_vector):
			var enemy = enemy_types[rand_range(0, enemy_types.size())].instance()
			enemy._set_start_pos(spawn_vector)
			self.add_child(enemy)
	
func _get_random_point(start: Vector2, end: Vector2, players: Dictionary) -> Vector2:
	var random_point = Vector2(rand_range(start.x, end.x), rand_range(start.y, end.y))
	while(not _is_far_enough(random_point, players)):

		random_point -= _get_direction_from_closest_player(random_point,players)
	return random_point

func _is_far_enough(point: Vector2, players: Dictionary) -> bool:
		var far_enough: int = 1
		
		for player in players.values():
			var distance = point.distance_to(player.get_global_position())
			far_enough *= 1 if distance > spawn_distance_limit else 0
		return bool(far_enough)
		
func _get_direction_from_closest_player(point: Vector2,players: Dictionary) -> Vector2:
	var closest_player
	var closest_distance = 3.402823e+38
	for player in players.values():
		var curr = player.global_position.distance_to(point)
		if curr < closest_distance:
			closest_distance = curr
			closest_player = player
	var dir_vector = closest_player.get_global_position() - point
	return dir_vector
		
	