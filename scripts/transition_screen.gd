extends Node2D

func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://scenes/play_game.tscn")

func _on_next_level_pressed():
	State.level += 1
	get_tree().change_scene_to_file("res://scenes/play_game.tscn")
