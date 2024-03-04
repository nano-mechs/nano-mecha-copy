# uses the same gun as player but stats(reload time, target layer, etc) are different
extends CharacterBody2D

signal killed

var target
var health = 1
var speed  = 300
var damage = 1
var bullet = preload("res://weapons/bullet.tscn")


func _ready():
	%Gun.target = "player"


func _physics_process(delta):
	# only move to the player until a certain distance away
	if global_position.distance_to(target.global_position) >= 800:
		var direction = global_position.direction_to(target.global_position)
		velocity = direction * speed
		move_and_slide()

	%Gun.look_at(target.global_position)
	%Gun.shoot(bullet)


func take_damage(damage = 1):
	health -= damage
	if health <= 0:
		killed.emit()
		queue_free()
		const SMOKE_EXPLOSION = preload("res://scenes/smoke_explosion.tscn")
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
