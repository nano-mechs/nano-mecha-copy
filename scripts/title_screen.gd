extends Control


func _ready():
	%EasyModeButton.button_pressed = State.easy_mode


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/play_game.tscn")


func _on_easy_mode_button_toggled(toggled_on):
	State.easy_mode = toggled_on
