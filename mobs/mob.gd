# every enemy exists in collision layer 2
extends CharacterBody2D

signal killed # everything emits a killed signal for when they... get killed

var target # value assigned(usually the player) on spawn from the parent scene
var health = 1
var speed  = 400 if State.easy_mode else 600
var damage = 1 # damage gets used when making contact with player


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
