extends Control

var exp_bar

var health_bar

var character

# Called when the node enters the scene tree for the first time.
func _ready():
	character = get_parent()
	exp_bar = $EXPBar
	health_bar = $HealthBar
	
	exp_bar.max_value = character.needed_exp
	exp_bar.value = character.current_exp
	
	health_bar.max_value = character.max_health
	health_bar.value = character.current_health
	
	
	character.connect("healt_changed", self, "_on_health_changed")
	character.connect("exp_earned", self, "_on_exp_earned")
	
func _on_health_changed():
	pass

func _on_exp_earned():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
