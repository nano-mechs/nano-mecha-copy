extends CharacterBody2D

signal killed # everything emits a killed signal for when they... get killed

var target # value assigned(usually the player) on spawn from the parent scene
var health = 1
var speed  = 300
var damage = 1


func _physics_process(delta):
	var direction = global_position.direction_to(target.global_position)
	velocity = direction * speed
	move_and_slide()


func take_damage(damage = 1):
	health -= damage
	if health <= 0:
		killed.emit()
		queue_free()
		const SMOKE_EXPLOSION = preload("res://scenes/smoke_explosion.tscn")
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
