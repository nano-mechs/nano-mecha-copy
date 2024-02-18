extends Node2D

var enemies = {
	"max_spawn_count": 100,
	"spawned": 0,
	"killed": 0,
	"types": [ preload("res://scenes/mob.tscn") ]
}

func _ready():
	start_level()

func _on_timer_timeout():
	spawn_enemy()

func _on_enemy_killed():
	enemies.killed += 1
	if enemies.killed == enemies.max_spawn_count:
		win_level()

# TODO: switch to "inbetween levels" scene
func win_level():
	pass

func start_level():
	%Timer.start()

func spawn_enemy():
	enemies.spawned += 1
	var new_enemy = enemies.types.pick_random().instantiate()
	%EnemySpawnLine.progress_ratio = randf()
	new_enemy.global_position = %EnemySpawnLine.global_position
	new_enemy.target = %Player
	add_child(new_enemy)
	new_enemy.connect("killed", _on_enemy_killed)
