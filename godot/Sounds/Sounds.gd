extends AudioStreamPlayer2D

var ah = preload("res://Sounds/Dmg/ah.wav")
var ah2 = preload("res://Sounds/Dmg/ah2.wav")
var au = preload("res://Sounds/Dmg/au.wav")
var aua = preload("res://Sounds/Dmg/aua.wav")
var aua2 = preload("res://Sounds/Dmg/aua2.wav")
var autsch = preload("res://Sounds/Dmg/autsch.wav")
var nein = preload("res://Sounds/Dmg/nein.wav")
var schaefchen = preload("res://Sounds/Dmg/schaefchen.wav")
var tutweh = preload("res://Sounds/Dmg/tutweh.wav")
var uf = preload("res://Sounds/Dmg/uf.wav")
var uh = preload("res://Sounds/Dmg/uh.wav")
var wilhelm = preload("res://Sounds/Dmg/wilhelm.wav")
var dmg = [ah, ah2, au, aua, aua2, autsch, nein, schaefchen, tutweh, uf, uh, wilhelm]

var poison1 = preload("res://Sounds/Poison/poison1.wav")
var poison2 = preload("res://Sounds/Poison/poison2.wav")
var poison = [poison1, poison2]

var health = preload("res://Sounds/Health/health.wav")

var stinky = preload("res://Sounds/Stinky/stinky.wav")

var mine = preload("res://Sounds/Mine/mine.wav")

var speed = preload("res://Sounds/Speed/speed.wav")

var power = preload("res://Sounds/Power/power.wav")
		
func play_dmg():
	randomize()
	stream = dmg[int(rand_range(0, dmg.size()))]
	play()
	
func play_poison():
	stream = poison[int(rand_range(0, dmg.size()))]
	play()
	
func play_health():
	stream = health
	play()
	
func play_stinky():
	stream = stinky
	play()
	
func play_mine():
	stream = mine
	play()
	
func play_speed():
	stream = speed
	play()
	
func play_power():
	stream = power
	play()