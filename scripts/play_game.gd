extends Node2D

# assigned in State
var enemies
var boss
var scene_switched = false # in case something tries to switch scenes when it already switched
var random_drop = false


# turns into boss level every 3rd level
func _ready():
	if State.level % 3 == 0:
		random_drop = true
		boss = State.assign_boss()
		boss.global_position = Vector2(100, 100)
		boss.target = %Player
		boss.connect("killed", _on_boss_killed)
		add_child(boss)
	else:
		random_drop = false
		enemies = State.assign_enemy_props()
		%EnemySpawnTimer.start()


func _physics_process(delta):
	if random_drop && randf() <= 0.01: # 1% chance for powerup to drop every frame
		print("random chance drop")
		call_deferred("drop_powerup", Vector2(randf_range(100, 3740),
							randf_range(100, 2060))) # within 100 pixels of the borders


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


func drop_powerup(coords):
	var powerup = State.powerups.pick_random().instantiate()
	powerup.target = %Player
	powerup.global_position = coords
	add_child(powerup)

#########################
## MOB LEVEL FUNCTIONS ##
#########################

func _on_enemy_spawn_timer_timeout():
	spawn_enemy()


# signal attached to every enemy by spawn_enemy() method
func _on_enemy_killed(coords):
	enemies.killed += 1
	if enemies.killed == enemies.max_spawn_count: call_deferred("win_level")
	# 5% chance to drop a powerup
	if randf() <= 0.05: call_deferred("drop_powerup", coords)


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
