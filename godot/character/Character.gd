extends KinematicBody2D

var sounds_pref = load("res://Sounds/Sounds.tscn")
var sounds


signal state_changed(state)

signal hit(damage)

signal died(id)

signal won(id)

signal lost(id)

signal attacked

signal exp_earned(xp, needed)

signal level_up(level, options)


signal health_changed(health, max_health)

#maxspeed in pixel per seconds
export (int, 1, 200) var ORIG_MAXSPEED = 200

#acceleration in pixel per second
export (int, 1, 200) var ORIG_ACCELERATION = 200

#decceleration in pixel per second
export (int, 1, 200) var ORIG_DECCELERATION = 100

#rotationspeed in degrees per second
export (float) var ORIG_MASS = 0.1

export (int, 1, 1000) var ORIG_HEALTH = 100

export (int, 1, 1000) var ORIG_ATTACKPOWER = 10

export (int, 1, 100) var ORIG_ADDATTACKS = 0

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

var add_attacks = ORIG_ADDATTACKS

var defense = ORIG_DEFENSE

var needed_exp = EXPFIRSTLEVEL

var current_exp = 0 setget _set_current_exp

var level = 0

var movement_vector = Vector2(0, 0)

var wanted_direction = Vector2(0, 0)

enum state {IDLE, MOVEING, GETHIT, DYING}

var current_state = state.IDLE

var is_stinky = false

var id

var color 

var camera

var controler

var attack

var level_up_options = {}

var exit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	sounds = sounds_pref.instance()
	add_child(sounds)
	
	start_idle()

	connect("died", self, "_on_died")
	
	camera = $Camera2D
	
	level_up_options.health = 20
	level_up_options.attack_power = 2
	level_up_options.defense_power = 2
	level_up_options.agility = 1.1
	level_up_options.add_attacks = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	
	match current_state:
		state.IDLE:
			idle(delta)
		state.MOVEING:
			moveing(delta)
		state.GETHIT:
			gethit(delta)
		state.DYING:
			dying(delta)


func start_idle():
	current_state = state.IDLE
	emit_signal("state_changed", "IDLE")
	
func start_moveing():
	current_state = state.MOVEING
	emit_signal("state_changed", "MOVEING")
	
func start_gethit():
	current_state = state.GETHIT
	var randau = randi() % sounds.dmg.size()
	sounds.stream = sounds.dmg[randau]
	sounds.play()
	emit_signal("state_changed", "GETHIT")
	
func start_dying():
	current_state = state.DYING
	emit_signal("state_changed", "DYING")
	emit_signal("died", id)
	
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
	
	global_rotation = stepify(movement_vector.angle(), 0.1) 


	var collider = move_and_collide(movement_vector * delta)
	
	if collider:
		movement_vector = Vector2(0, 0)
	
		
	

func gethit(delta):
	start_idle()
	
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
	self.current_health = clamp(current_health - clamp(damage - defense, 0, damage), 0, max_health)
	start_gethit() 
	
func _set_current_health(health):
	current_health = clamp(health, 0, max_health)
	if current_health == 0:
		if current_state != state.DYING:
			start_dying()
	emit_signal("health_changed", health, max_health)
	
func _set_current_exp(ep):
	current_exp = ep
	if current_exp >= needed_exp:
		current_exp -= needed_exp
		needed_exp = needed_exp / EXPSSCALE
		level += 1
		
		var option_keys = level_up_options.keys()
		var key_1 = option_keys[randi() % option_keys.size()]
		var key_2 = option_keys[randi() % option_keys.size()]
		var options = [key_1, key_2]
		
		
		emit_signal("level_up", level, options)
		
	emit_signal("exp_earned", current_exp, needed_exp)

func _on_died(id):
	call_deferred("free")

func _on_level_up_chosen(option):
	match option:
		"health":
			self.max_health += level_up_options[option]
		"attack_power":
			attack_power += level_up_options[option]
		"defense_power":
			defense += level_up_options[option]
		"agility":
			max_speed *= level_up_options[option]
			acc *= level_up_options[option]
			decc *= level_up_options[option]
			mass /= level_up_options[option]
		"add_attacks":
			add_attacks += level_up_options[option]
	current_health = max_health

func register_controler(controler):
	self.controler = controler
	
func register_attack(attack):
	self.attack = attack

func joy_input(event):
	controler.joy_input(event)
	
func _input(event):
	if controler:
		controler.joy_input(event)
		
func set_up(spawn_rect, color, id):
	
	global_position = Vector2(rand_range(spawn_rect.position.x, spawn_rect.end.x),
			rand_range(spawn_rect.position.y, spawn_rect.end.y))
			
	$Sprite.modulate = color
	
	self.color = color
	
	self.id = id