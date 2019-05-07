	extends KinematicBody2D

const Character = preload("res://character/Character.gd")
export var  MAX_SPEED = 500
export var  MAX_FORCE = 0.02

onready var spawn_point = get_global_position()
onready var tweener: Tween = get_node("Properties/Tween")
onready var player_detector: CollisionShape2D = get_node("Properties/PlayerDetector/CollisionShape2D")
onready var death_explosion: Particles2D = get_node("Particles2D")
onready var character : Character


onready var weak_tween = weakref(tweener)
var kinematic_velocity : Vector2 = Vector2()
var patrol_step = 0
var alive:bool = true
enum state {CHASE, FLEE, PATROL}
export var current_state = state.PATROL
# ====================
# 	GODOT Lifecycle
# ====================

func _ready():
		handle_state()
		
func _process(delta):
	update()

func _physics_process(delta):
	if is_queued_for_deletion() or current_state == state.PATROL:
		return
	kinematic_velocity = steer()
	var collision = move_and_collide(kinematic_velocity * delta)
	
	if collision:
		if collision.collider is Character:
			var collided_player : Character = collision.collider
			collided_player.hit(25)
			kill_self()
#player_target = get_viewport().get_mouse_position()
	
#func _draw():
#	if character:
#		draw_line(Vector2(), kinematic_velocity, Color(255,0,0))

# ====================
# 	State Handlers
# ====================
func handle_state():
	match current_state:
		state.PATROL:
			patrol()
			
func patrol():
	if patrol_step < 10:
		move_to(get_patrol_point())
		patrol_step += 1
	else:
		patrol_step = 0
		var distance_vector = spawn_point - global_position
		var lerp_velocity = rand_range(MAX_SPEED/8,(MAX_SPEED/3))
		var d = distance_vector.length()
	
		var time = d / lerp_velocity
		tweener.interpolate_property(self,"position",global_position,spawn_point, time, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tweener.start()
	
# ====================
# 		Logic
# ====================
func _set_start_pos(pos: Vector2):
	global_position = pos
	spawn_point = pos
	
func kill_self():

	set_physics_process(false)
	set_process(false)
	alive = false
	$Properties.queue_free()
	$Hitbox.queue_free()
	death_explosion.set_emitting(true)
	
	$Timer.start(death_explosion.lifetime)
	yield($Timer, "timeout")
	call_deferred("free")
	
	
func get_patrol_point():
	var radius = player_detector.shape.radius
	var angle = deg2rad(rand_range(0,360))
	return global_position + radius * Vector2(cos(angle), sin(angle))
	
func move_to(target_pos):
	var distance_vector = target_pos - global_position
	var lerp_velocity = rand_range(MAX_SPEED/8,(MAX_SPEED/3))
	var d =  distance_vector.length() if distance_vector.length() != 0 else 1 
	
	var time = d / lerp_velocity
	var norm = distance_vector.normalized()
	var integral = Vector2((norm.x * norm.x) / 2, (norm.y * norm.y) / 2) * d / 60
	tweener.interpolate_method(self,"tween_movement",Vector2(),integral, time*2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tweener.start()

func tween_movement(vel: Vector2):
	move_and_collide(vel)
	
func steer():
	if is_instance_valid(character) and character is Character:
		
		var target = character.global_position
		var desired_velocity = (target - global_position).normalized() * MAX_SPEED
		if state.FLEE == current_state:
			desired_velocity = -desired_velocity
		var acceleration = desired_velocity - kinematic_velocity
		var target_velocity = kinematic_velocity + (acceleration * MAX_FORCE)
		return(target_velocity)
	
	current_state = state.PATROL
	return Vector2()

# ====================
# 		SIGNALS
# ====================

func on_player_detected(body):
	if body is Character:
		character = body
		if character.is_stinky:
			current_state = state.FLEE
		else:
			current_state = state.CHASE
		if weak_tween.get_ref():
			tweener.stop_all()	
		set_physics_process(true)

func on_player_exit(body):
	if body is Character:
		if body == character:
			body = null
			$Timer.start(1)
			yield($Timer, "timeout")	
			if current_state != state.PATROL:
				set_physics_process(false)
				if weak_tween.get_ref():
					tweener.reset_all()
					current_state = state.PATROL
					handle_state()
	
func _on_movement_tween_completed(object, key):
	$Timer.start(rand_range(1,3))
	yield($Timer, "timeout")
	if current_state == state.PATROL and alive:
		patrol()
	
