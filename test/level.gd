extends Node2D

var enemies = {
	"max_spawn": 10,
	"spawned": 0,
	"killed": 0,
	"types": [ preload("res://test/enemy.tscn") ]
}
var level = 1
var lives = 3

func reset():
	# default stuff
	enemies = {
		"max_spawn": 10,
		"spawned": 0,
		"killed": 0,
		# insert array of different scenes of enemies here(changes per level)
		"types": [ preload("res://test/enemy.tscn") ]
	}
	# unique to every level stuff
	# godot switch/case statement
	match level:
		1: pass
		2:
			enemies.max_spawn = 50
			enemies.types = [
				preload("res://test/enemy.tscn"),
				preload("res://test/enemy2.tscn")
			]
		3: pass

	start_level()

func spawn_enemy():
	enemies.spawned += 1
	var new_enemy = enemies.types.pick_random().instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_enemy.global_position = %PathFollow2D.global_position
	add_child(new_enemy)
	new_enemy.connect("killed", _on_enemy_killed)

func start_level():
	for i in 5:
		spawn_enemy()
	%Timer.start()

# on first run of the scene
func _ready():
	start_level()

func _on_timer_timeout():
	if enemies.spawned == enemies.max_spawn: return
	else: spawn_enemy()

func win_level():
	level += 1
	reset()

# runs on a signal from the enemy type script
# in other words, every enemy must have a "killed" signal
func _on_enemy_killed():
	enemies.killed += 1
	%ColorRect.visible = !%ColorRect.visible
	if enemies.killed == enemies.max_spawn:
		win_level()
