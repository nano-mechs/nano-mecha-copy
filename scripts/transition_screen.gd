extends Node2D

func _on_restart_button_pressed():
	get_tree().change_scene_to_file(State.prev_scene)

func _on_next_level_pressed():
	State.level += 1
	
	if (State.level % 3 == 0): 
		get_tree().change_scene_to_file("res://scenes/boss_level.tscn")
	else: 
		get_tree().change_scene_to_file("res://scenes/play_game.tscn")
