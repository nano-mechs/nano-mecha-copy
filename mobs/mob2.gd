extends CharacterBody2D

signal killed

var target
var health = 2 if State.easy_mode else 4
var speed  = 100
var damage = 2


func _physics_process(delta):
	var direction = global_position.direction_to(target.global_position)
	velocity = direction * speed

	if velocity.x < 0: %AnimatedSprite2D.flip_h = true
	else: %AnimatedSprite2D.flip_h = false
	move_and_slide()


func take_damage(damage = 1):
	health -= damage
	if health <= 0:
		killed.emit(global_position)
		queue_free()
		const SMOKE_EXPLOSION = preload("res://scenes/smoke_explosion.tscn")
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
