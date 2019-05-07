extends Area2D

var body
var timer

enum TYPE {PRIMARY, SECONDARY}

export (int, 1, 60) var cooldown = 2
export (float, 0.1, 1) var time_between_shots = 0.25

export (int, 1, 10) var max_shots = 3
export var projectile = preload("res://character/Attacks/DamageProjectile.tscn")
export (int, 0, 1000) var attack_range = 200
export (TYPE) var type = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	body = get_parent()
	match type:
		TYPE.PRIMARY:
			body.register_attack_primary(self)
		TYPE.SECONDARY:
			body.register_attack_secondary(self)
	$AttackArea.shape = $AttackArea.shape.duplicate()
	
	$AttackArea.shape.radius = attack_range
	max_shots += body.add_attacks
	
	timer = $Timer
	

func attack():
	if timer.is_stopped():
		if get_overlapping_bodies().size() <= 1:
			if get_overlapping_bodies().size() == 0:
				return
			for target in get_overlapping_bodies():
				if target == body:
					return
		var shots = max_shots
		while(shots > 0 and get_overlapping_bodies().size() > 0):
			for target in get_overlapping_bodies():
				if target == body:
					continue
				var new_projectile = projectile.instance()
				
				var spawn_point = body.global_position
				spawn_point.x = rand_range(body.global_position.x - 50, body.global_position.x + 50)
				spawn_point.y = rand_range(body.global_position.y - 50, body.global_position.y + 50)
				new_projectile.setup(target, body.attack_power, body.color, body, spawn_point)
				Game.world.add_child(new_projectile)
				timer.start(time_between_shots)
				yield(timer, "timeout")
				shots -= 1
		timer.start(cooldown)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
