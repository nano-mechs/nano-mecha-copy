extends Node2D

# assigned in State
var enemies
var boss
var scene_switched = false # in case something tries to switch scenes when it already switched


# turns into boss level every 3rd level
func _ready():
	if State.level % 3 == 0:
		boss = State.assign_boss()
		boss.global_position = Vector2(0, 0)
		boss.connect("killed", _on_boss_killed)
		add_child(boss)
	else:
		enemies = State.assign_enemy_props()
		%EnemySpawnTimer.start()


func win_level():
	if scene_switched: return
	scene_switched = true
	get_tree().change_scene_to_file("res://scenes/transition_screen.tscn")


func lose_level():
	if scene_switched: return
	scene_switched = true
	get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")


func _on_player_killed():
	call_deferred("lose_level")

#########################
## MOB LEVEL FUNCTIONS ##
#########################

func _on_enemy_spawn_timer_timeout():
	spawn_enemy()


# signal attached to every enemy by spawn_enemy() method
func _on_enemy_killed():
	enemies.killed += 1
	if enemies.killed == enemies.max_spawn_count:
		call_deferred("win_level") # call_deferred to call the function at the end of a tick


func spawn_enemy():
	if enemies.spawned == enemies.max_spawn_count: return

	enemies.spawned += 1
	var new_enemy = enemies.types.pick_random().instantiate()
	%EnemyPathProgress.progress_ratio = randf()
	new_enemy.global_position = %EnemyPathProgress.global_position
	new_enemy.target = %Player
	new_enemy.connect("killed", _on_enemy_killed) # attach signal to method
	add_child(new_enemy)

##########################
## BOSS LEVEL FUNCTIONS ##
##########################

func _on_boss_killed():
	call_deferred("win_level") # call_deferred to call the function at the end of a tick
