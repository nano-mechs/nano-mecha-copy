extends CharacterBody2D

var health = 1

@onready var player = get_node("/root/Game/Player")


func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()

func take_damage():
	health -= 1
	if health == 0:
		queue_free()
		const SMOKE_EXPLOSION = preload("res://scenes/smoke_explosion.tscn")
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
