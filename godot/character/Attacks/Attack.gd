extends Area2D

var body
var area
var timer

var cooldown = 2

var max_shots = 3

var projectile = preload("res://character/Attacks/DamageProjectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	body = get_parent()
	body.register_attack(self)
	
	max_shots += body.add_attacks
	
	timer = $Timer
	

func attack():
	if timer.is_stopped() and get_overlapping_bodies().size() > 1:
		var shots = max_shots
		while(shots > 0 and get_overlapping_bodies().size() > 1):
			for target in get_overlapping_bodies():
				if target == body:
					continue
				var new_projectile = projectile.instance()
				
				var spawn_point = body.global_position
				spawn_point.x = rand_range(body.global_position.x - 30, body.global_position.x + 30)
				spawn_point.y = rand_range(body.global_position.y - 30, body.global_position.y + 30)
				new_projectile.setup(target, body.attack_power, body.color, body, spawn_point)
				Game.world.add_child(new_projectile)
				shots -= 1
		timer.start(cooldown)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
