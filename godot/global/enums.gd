extends Node

enum ConsumType{
	XP,
	Speed,
	Attack,
	Health,
	Poison
}
	
func get_rand_consumType():
	return enums.ConsumType[rand_range(0, enums.ConsumType.size())]