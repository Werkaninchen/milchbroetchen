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
	
func _on_health_changed(health):
	health_bar.value = health

func _on_exp_earned(xp, needed_xp):
	exp_bar.max_value = needed_xp
	exp_bar.value = xp
	
func _on_level_up(new_level, options):
	level.text = "LV " + str(new_level)
	self.options = options
	match options:
		"health":
			pass
		"attack_power":
			pass
		"defense_power":
			pass
		"agility":
			pass
		"add_attacks":
			pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
