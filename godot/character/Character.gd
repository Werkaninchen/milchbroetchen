extends KinematicBody2D

# warning-ignore:unused_signal
signal eaten

signal state_changed(state)

# warning-ignore:unused_signal
signal hit(damage)

# warning-ignore:unused_signal
signal died

# warning-ignore:unused_signal
signal attacked

# warning-ignore:unused_signal
signal exp_earned(xp, needed)

# warning-ignore:unused_signal
signal level_up(level)

# warning-ignore:unused_signal
signal power_up_added(color)

signal debuff_added(color)

# warning-ignore:unused_signal
signal power_up_removed

# warning-ignore:unused_signal
signal debuff_removed

# warning-ignore:unused_signal
signal health_changed(health)

#maxspeed in pixel per seconds
export (int, 1, 200) var ORIG_MAXSPEED = 200

#acceleration in pixel per second
export (int, 1, 200) var ORIG_ACCELERATION = 200

#decceleration in pixel per second
export (int, 1, 200) var ORIG_DECCELERATION = 100

#rotationspeed in degrees per second
export (float) var ORIG_MASS = 0.3

export (int, 1, 1000) var ORIG_HEALTH = 100

export (int, 1, 1000) var ORIG_ATTACKPOWER = 10

export (int, 1, 1000) var ORIG_DEFENSE = 10

#needed EXP for first Level
export (int) var EXPFIRSTLEVEL = 1000

#diminisher for xp need
export (float, 0.1, 1) var EXPSSCALE = 0.5

var max_speed = ORIG_MAXSPEED

var acc = ORIG_ACCELERATION

var decc = ORIG_DECCELERATION

var mass = ORIG_MASS 

var max_health = ORIG_HEALTH

var current_health = ORIG_HEALTH setget _set_current_health

var attack_power = ORIG_ATTACKPOWER

var defense = ORIG_DEFENSE

var needed_exp = EXPFIRSTLEVEL

var current_exp = 0 setget _set_current_exp

var level = 0

var movement_vector = Vector2(0, 0)

var wanted_direction = Vector2(0, 0)

enum state {IDLE, MOVEING, EATING, GETHIT, ATTACKING, DYING}

var current_state = state.IDLE

var id

var camera

var controler

# Called when the node enters the scene tree for the first time.
func _ready():
	start_idle()
# warning-ignore:return_value_discarded
	connect("died", self, "_on_died")
	connect("level_up", self, "_on_level_up")
	
	camera = $Camera2D

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
	emit_signal("state_changed", "IDLE")
	
func start_moveing():
	current_state = state.MOVEING
	emit_signal("state_changed", "MOVEING")
	
func start_eating():
	current_state = state.EATING
	emit_signal("state_changed", "EATING")
	
func start_gethit():
	current_state = state.GETHIT
	emit_signal("state_changed", "GETHIT")
	
func start_attacking():
	current_state = state.ATTACKING
	emit_signal("state_changed", "ATTACKING")
	
func start_dying():
	current_state = state.DYING
	emit_signal("state_changed", "DYING")
	
func idle(delta):
	if wanted_direction != Vector2(0, 0):
		start_moveing()
		return
		
	if movement_vector != Vector2(0,0):
		movement_vector -= movement_vector.normalized() * decc * delta
	
		if abs(movement_vector.length()) < decc * delta:
			movement_vector = Vector2(0, 0)
		
		else:
			var collider = move_and_collide(movement_vector * delta)
			
			if collider:
				movement_vector = Vector2(0, 0)
	
		
	
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


	var collider = move_and_collide(movement_vector * delta)
	
	if collider:
		movement_vector = Vector2(0, 0)
	
		
	

func eating(delta):
	pass
	

func gethit(delta):
	start_idle()
	

func attacking(delta):
	pass
	
func dying(delta):
	if movement_vector != Vector2(0,0):
		movement_vector -= movement_vector.normalized() * decc * delta
	
		if abs(movement_vector.length()) < decc * delta:
			movement_vector = Vector2(0, 0)
		
		else:
			var collider = move_and_collide(movement_vector * delta)
			
			if collider:
				movement_vector = Vector2(0, 0)
	
func hit(damage):
	current_health = clamp(current_health - clamp(damage - defense, 0, damage), 0, max_health)
	if current_health == 0:
		start_dying()
		return
	start_gethit() 
	
	
func _set_current_health(health):
	current_health = clamp(health, 0, max_health)
	if current_health == 0:
		start_dying()
	emit_signal("health_changed", health)
	
func _set_current_exp(ep):
	current_exp = ep
	if current_exp >= needed_exp:
		current_exp -= needed_exp
		needed_exp = needed_exp / EXPSSCALE
		level += 1
		emit_signal("level_up", level)
		
	emit_signal("exp_earned", current_exp, needed_exp)

func _on_died():
	queue_free()

func _on_level_up():
	pass

func register_controler(controler):
	self.controler = controler

func joy_input(event):
	controler.joy_input(event)
	
func _input(event):
	if controler:
		controler.joy_input(event)