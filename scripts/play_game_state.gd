# Global scripts that contains variables that require state to be kept when switching scenes
# TODO: add more levels/randomize/difficulty ramp up
# TODO: make game a game
extends Node

# global vars accessed via State.<var name>
var level = 1
var powerups = [
	preload("res://powerups/piercer.tscn")
]

# returns a hash that contains the enemy types
func assign_enemy_props():
	var enemies = { "spawned": 0, "killed": 0 }

	match level:
		1:
			enemies.max_spawn_count = 100
			enemies.types = [
				preload("res://mobs/mob.tscn"),
				#preload("res://mobs/teleporter.tscn"),
			]
		2:
			enemies.max_spawn_count = 200
			enemies.types = [
				preload("res://mobs/mob2.tscn"),
				preload("res://mobs/ranged.tscn")
			]
		4:
			enemies.max_spawn_count = 300
			enemies.types = [
				preload("res://mobs/mob2.tscn"),
				preload("res://mobs/ranged.tscn"),
				preload("res://mobs/mob.tscn")
			]
	return enemies


# every 3 levels, becomes a boss fight
func assign_boss():
	match level:
		3: return load("res://bosses/boss1.tscn").instantiate()


# returns the string for the current level's background sprite
# TODO make it actually work
func assign_bg_sprite():
	match level:
		1: return "res://sprites/backgrounds/ExK_q-IVcAUM7Qu.png"
		2: return "res://sprites/backgrounds/pixel-art-night-city-seamless-background-detailed-vector-23730672.png"


