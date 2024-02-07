extends Node2D

static var enemies = {
	"max_spawn_count": 100,
	"spawned": 0,
	"killed": 0
}

func _ready():
	for i in 5:
		spawn_mob()

func spawn_mob():
	if enemies.spawned >= enemies.max_spawn_count: return
	
	var new_mob = preload("res://scenes/mob.tscn").instance()
	var spawn_point = Vector2(randf_range(-100, get_viewport_rect().size.x + 100), randf_range(-100, get_viewport_rect().size.y + 100))
	new_mob.global_position = spawn_point
	add_child(new_mob)
	enemies.spawned += 1

func _on_timer_timeout():
	# limits the number of enemies that can appear in one go
	if abs(enemies.spawned - enemies.killed) <= 10:
		spawn_mob()

func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true

func _on_start_over_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
