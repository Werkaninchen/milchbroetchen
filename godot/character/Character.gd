extends KinematicBody2D

#maxspeed in pixel per seconds
export (int, 1, 200) var ORIG_MAXSPEED = 200

#acceleration in pixel per second
export (int, 1, 200) var ORIG_ACCELERATION = 200

#decceleration in pixel per second
export (int, 1, 200) var ORIG_DECCELERATION = 100

#rotationspeed in degrees per second
export (float) var ORIG_MASS = 0.3

export (int, 1, 1000) var ORIG_HEALTH = 100

#needed EXP for first Level
export (int) var EXPFIRSTLEVEL

#diminischer for xp need
export (float, 0.1, 1) var EXPSSCALE

var max_speed = ORIG_MAXSPEED

var acc = ORIG_ACCELERATION

var decc = ORIG_DECCELERATION

var mass = ORIG_MASS

var max_health = ORIG_HEALTH

var current_health = ORIG_HEALTH

var needed_exp = EXPFIRSTLEVEL

var movement_vector = Vector2(0, 0)

var current_direction = Vector2(0, 0)

var wanted_direction = Vector2(0, 0)

enum state {IDLE, MOVEING, EATING, GETHIT, ATTACKING, DYING}

var current_state = state.IDLE

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	start_idle()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	
	match current_state:
		state.IDLE:
			idle(delta)
		state.MOVEING:
			moveing(delta)
		state.EATING:
			eating(delta)
		state.GETHIT:
			gethit(delta)
		state.ATTACKING:
			attacking(delta)
		state.DYING:
			dying(delta)


func start_idle():
	current_state = state.IDLE
	
func start_moveing():
	current_state = state.MOVEING
	
func start_eating():
	current_state = state.EATING
	
func start_gethit():
	current_state = state.GETHIT
	
func start_attacking():
	current_state = state.ATTACKING
	
func start_dying():
	current_state = state.DYING
	
func idle(delta):
	if wanted_direction != Vector2(0, 0):
		start_moveing()
		return
		
	if movement_vector != Vector2(0,0):
		movement_vector -= movement_vector.normalized() * decc * delta
	
		if abs(movement_vector.length()) < decc * delta:
			movement_vector = Vector2(0, 0)
		
		else:
			move_and_collide(movement_vector * delta)
	
		
	
func moveing(delta):
	if wanted_direction == Vector2(0, 0):
		start_idle()
		return
		
	var speed = clamp(movement_vector.length() + acc * delta, 0, max_speed * wanted_direction.length()) 
	
	var target_movement = speed * wanted_direction.normalized()
	var steering = target_movement - movement_vector

	if steering.length() > 1:
		steering = steering.normalized()
	
	movement_vector += steering / mass
	
	#global_rotation = movement_vector.angle()

	move_and_collide(movement_vector * delta)
	
		
	
func eating(delta):
	pass
	
func gethit(delta):
	pass
	
func attacking(delta):
	pass
	
func dying(delta):
	pass
	
func hit(body):
	pass