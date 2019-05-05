extends Node

func change_to_scene(new_instance):
	get_tree().current_scene.free()
	get_tree().root.add_child(new_instance)