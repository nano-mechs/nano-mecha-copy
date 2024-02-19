extends Node2D

# assigned in State
var enemies

func _ready():
	start_level()

# TODO: assign proper values to `enemies` every level
func start_level():
	enemies = State.assign_level_props()
	%Timer.start()

func _on_timer_timeout():
	spawn_enemy()

func _on_player_killed():
	get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")

# signal attached to every enemy by spawn_enemy() method
func _on_enemy_killed():
	enemies.killed += 1
	if enemies.killed == enemies.max_spawn_count:
		win_level()

# TODO: switch to "inbetween levels" scene to give player a break/savepoint
func win_level():
	State.level += 1
	# get_tree().change_scene_to_file(<this scene hasn't been made yet>)
	print("win level")

func spawn_enemy():
	if enemies.spawned == enemies.max_spawn_count: return

	enemies.spawned += 1
	var new_enemy = enemies.types.pick_random().instantiate()
	%EnemySpawnLine.progress_ratio = randf()
	new_enemy.global_position = %EnemySpawnLine.global_position
	new_enemy.target = %Player
	new_enemy.connect("killed", _on_enemy_killed) # attach signal to method
	add_child(new_enemy)
