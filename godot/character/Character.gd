extends KinematicBody2D

#speed in pixel per seconds
export (int, 1, 200) var ORIG_SPEED = 50

#acceleration in pixel per second
export (int, 1, 200) var ORIG_ACCELERATION = 25

#decceleration in pixel per second
export (int, 1, 200) var ORIG_DECCELERATION = 10

#rotationspeed in degrees per second
export (int, 1, 360) var ORIG_ROTSPEED = 10

export (int, 1, 1000) var ORIG_HEALTH = 100

#needed EXP for first Level
export (int) var EXPFIRSTLEVEL

#diminischer for xp need
export (float, 0.1, 1) var EXPSSCALE

var speed = ORIG_SPEED

var acc = ORIG_ACCELERATION

var decc = ORIG_DECCELERATION

var rot_speed = ORIG_ROTSPEED

var max_healt = ORIG_HEALTH

var current_health = ORIG_HEALTH

var needed_exp = EXPFIRSTLEVEL

var movement_vector = Vector2(0, 0)

var direction = Vector2(0, 0)

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
	pass
	
func moveing(delta):
	pass
	
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