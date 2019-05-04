extends KinematicBody2D

const Character = preload("res://character/Character.gd")
export var  MAX_SPEED = 500
export var  MAX_FORCE = 0.02

onready var player_target = position

var character : Character 
var velocity = Vector2()

export (int, "SEEK", "FLEE") var mode = 0
func _ready():
	set_physics_process(true)
	set_process(true)
	


func _process(delta):
    update()

func _physics_process(delta):
	velocity = steer(player_target)
	move_and_slide(velocity )
	player_target = get_viewport().get_mouse_position()
	
func _draw():
	draw_line(Vector2(), velocity, Color(255,0,0))
	
func steer(target):
	var desired_velocity = (player_target - get_global_position()).normalized() * MAX_SPEED
	if mode == 1:
		desired_velocity = -desired_velocity
	var steer = desired_velocity - velocity
	var player_target_velocity = velocity + (steer * MAX_FORCE)
	return(player_target_velocity)


func on_player_detected(body):
	if not body is Character:
		return
	character = body
	player_target = character.position
	set_physics_process(true)


func on_player_exit(body):
	if not body is Character:
		return
	set_physics_process(false)
	
