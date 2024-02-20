extends CharacterBody2D

var health = 100

@onready var player = get_node("/root/Game/Player")

func take_damage():
	health -= 1
	%BossHealth.value = health
	if health == 0:
		queue_free()
		const SMOKE_EXPLOSION = preload("res://scenes/smoke_explosion.tscn")
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
