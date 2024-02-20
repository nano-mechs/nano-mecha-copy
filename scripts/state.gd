# GLOBAL STUFF THAT NEEDS TO MAINTAIN STATE PASSED BETWEEN SCENES GO HERE
extends Node

var prev_scene = null
var level = 1
var lives = 3

func assign_enemy_props():
	var enemies = { "spawned": 0, "killed": 0 }

	match level:
		1:
			enemies.max_spawn_count = 10
			enemies.types = [ preload("res://scenes/ranged.tscn") ]
		2:
			enemies.max_spawn_count = 100
			enemies.types = [
				preload("res://scenes/mob2.tscn"),
				preload("res://scenes/ranged.tscn")
			]

	return enemies
