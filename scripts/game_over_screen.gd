extends Node2D


func _ready():
	%EasyModeButton.button_pressed = State.easy_mode


func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://scenes/play_game.tscn")


func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")


func _on_easy_mode_button_toggled(toggled_on):
	State.easy_mode = toggled_on
