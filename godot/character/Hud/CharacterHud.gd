extends Control

var exp_bar

var level

var health_bar

var character

var level_container


var level_left

var level_right

var options

signal level_up_chosen(option)

# Called when the node enters the scene tree for the first time.
func _ready():
	character = get_parent().get_parent().player
	exp_bar = $HBC/EXPBar
	health_bar = $HealthBar
	level = $HBC/Level
	
	level_container = $LevelContainer
	level_left = $LevelContainer/MC/Left
	level_right = $LevelContainer/MC/Right
	
	
	exp_bar.max_value = character.needed_exp
	exp_bar.value = character.current_exp
	
	health_bar.max_value = character.max_health
	health_bar.value = character.current_health
	
	
	character.connect("health_changed", self, "_on_health_changed")
	character.connect("exp_earned", self, "_on_exp_earned")
	character.connect("level_up", self, "_on_level_up")
	connect("level_up_chosen", character, "_on_level_up_chosen")
	
func _on_health_changed(health, max_health):
	health_bar.value = health
	health_bar.max_value = max_health

func _on_exp_earned(xp, needed_xp):
	exp_bar.max_value = needed_xp
	exp_bar.value = xp
	
func _on_level_up(new_level, options):
	character.movement_vector = Vector2(0, 0)
	level.text = "LV " + str(new_level)
	self.options = options
	match options[0]:
		"health":
			level_left.text = "Health Up"
		"attack_power":
			level_left.text = "Attack Power Up"
		"defense_power":
			level_left.text = "Defense Up"
		"agility":
			level_left.text = "Agility Up"
		"add_attacks":
			level_left.text = "Attack Number Up"
			
	match options[1]:
		"health":
			level_right.text = "Health Up"
		"attack_power":
			level_right.text = "Attack Power Up"
		"defense_power":
			level_right.text = "Defense Up"
		"agility":
			level_right.text = "Agility Up"
		"add_attacks":
			level_right.text = "Attack Number Up"
			
	level_container.show()
	
func joy_input(event):
	if level_container.visible:
		if event is InputEventJoypadButton:
			if event.button_index == JOY_DPAD_LEFT:
				options.remove(1)
				emit_signal("level_up_chosen", options[0])
				level_container.hide()
			elif event.button_index == JOY_DPAD_RIGHT:
				options.remove(0)
				emit_signal("level_up_chosen", options[0])
				level_container.hide()
		return true
	return false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
