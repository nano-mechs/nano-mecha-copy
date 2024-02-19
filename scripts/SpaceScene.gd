extends Node2D

func _ready():
	for i in 5:
		spawn_mob()


func spawn_mob():
	var new_mob = preload("res://scenes/ranged.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


func _on_timer_timeout():
	spawn_mob()


func _on_player_killed():
	%GameOver.visible = true
	get_tree().paused = true


func _on_start_over_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

