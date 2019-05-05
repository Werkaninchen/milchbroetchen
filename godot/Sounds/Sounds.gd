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

var dot = preload("res://Sounds/Dot/dot.wav")
		
func play_dmg():
	randomize()
	stream = dmg[rand_range(0, dmg.size())]
	play()
	
func play_dot():
	stream = dot
	play()