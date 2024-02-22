extends Node2D


func _on_player_killed():
	State.prev_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")
