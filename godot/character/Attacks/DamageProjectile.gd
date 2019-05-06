extends Area2D

var base_damage = 10
var speed = 400
var target
var timer
var lifetime = 2
var originbody
var spawn_point

var color

var move_vector

func _ready():
	timer = $Timer
	timer.connect("timeout", self, "_on_timeout")
	timer.start(lifetime)
	
	connect("body_entered", self, "_on_body_entered")
	
	global_position = spawn_point
	
	$Sprite.rotate(get_angle_to(target.global_position))
	
	$Sprite.modulate = color
	
	move_vector = (target.global_position - global_position).normalized()
	
	

func setup(target, attackpower, color, origin, spawn_point):
	self.target = target
	base_damage += attackpower
	self.color = color
	originbody = origin
	self.spawn_point = spawn_point
	
	
	
	
func _physics_process(delta):
	
	global_position += move_vector * speed * delta
	
func _on_timeout():
	queue_free()
	
func _on_body_entered(body):
	if body != originbody and body.has_method("hit"):
		body.hit(base_damage)
		queue_free()



	
