# Global scripts that contains variables that require state to be kept when switching scenes
# TODO: add more levels/randomize/difficulty ramp up
# TODO: make game a game
extends Node

# global vars accessed via State.<var name>
var prev_scene = null
var level = 1
var lives = 3


# returns a hash that contains the enemy types
func assign_enemy_props():
	var enemies = { "spawned": 0, "killed": 0 }

	match level:
		1:
			enemies.max_spawn_count = 1
			enemies.types = [ preload("res://scenes/ranged.tscn") ]
		2:
			enemies.max_spawn_count = 1
			enemies.types = [
				preload("res://scenes/mob2.tscn"),
				preload("res://scenes/ranged.tscn")
			]

	return enemies

# returns the string for the current level's background sprite
func assign_bg_sprite():
	match level:
		1: return "res://sprites/backgrounds/ExK_q-IVcAUM7Qu.png"
		2: return "res://sprites/backgrounds/pixel-art-night-city-seamless-background-detailed-vector-23730672.png"


