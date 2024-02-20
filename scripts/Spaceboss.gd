extends Node2D


func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true


func _on_start_over_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
