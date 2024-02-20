extends Node2D

static var enemies = {
	"max_spawn_count": 50,
	"spawned": 0,
	"killed": 0
}

func _ready():
	for i in 5:
		spawn_mob()
	
	
func spawn_mob():
	if enemies.spawned >= enemies.max_spawn_count: return
	
	var new_mob = preload("res://scenes/mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	enemies.spawned += 1


func _on_timer_timeout():
	# limits number of enemies that can appear in one go
	if abs(enemies.spawned - enemies.killed) <= 10:
		spawn_mob()


func _on_player_killed():
	%GameOver.visible = true
	get_tree().paused = true


func _on_start_over_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func transition_to_new_scene():
		get_tree().change_scene_to_file("res://scenes/SpaceScene.tscn")
