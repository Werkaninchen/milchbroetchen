extends KinematicBody2D

const MAX_SPEED = 500
const MAX_FORCE = 0.02
var velocity = Vector2()
onready var target = position

export (int, "SEEK", "FLEE") var mode = 0
func _ready():
	set_physics_process(true)
	set_process(true)
	


func _process(delta):
    update()

func _physics_process(delta):
	velocity = steer(target)
	move_and_slide(velocity )
	target = get_viewport().get_mouse_position()
	
func _draw():
	draw_line(Vector2(), velocity, Color(255,0,0))
	
func steer(target):
	var desired_velocity = (target - get_global_position()).normalized() * MAX_SPEED
	if mode == 1:
		desired_velocity = -desired_velocity
	var steer = desired_velocity - velocity
	var target_velocity = velocity + (steer * MAX_FORCE)
	return(target_velocity)


func on_player_detected(body):
	if not body is Character:
		return
	player_target = body.position
	set_physics_process(true)


func on_player_exit(body):
	if not body is Character:
		return
	set_physics_process(false)
	
