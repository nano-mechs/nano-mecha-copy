extends CharacterBody2D

# value assigned(usually the player) on spawn from the parent scene
var target

func _physics_process(delta):
	var direction = global_position.direction_to(target.global_position)
	velocity = direction * 300.0
	move_and_slide()

func take_damage():
	queue_free()
	const SMOKE_EXPLOSION = preload("res://scenes/smoke_explosion.tscn")
	var smoke = SMOKE_EXPLOSION.instantiate()
	get_parent().add_child(smoke)
	smoke.global_position = global_position
