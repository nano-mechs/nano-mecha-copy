extends CharacterBody2D

# EVERY MOB SHOULD HAVE A KILLED SIGNAL
signal killed
var health = 100
var speed = 65
var damage = 4

func _physics_process(delta):
	%MoveProgress.progress += speed
	# DO NOT CHANGE TO %MoveProgress.global_position
	# IT JUST WORKS LIKE THIS, I DON'T KNOW WHY
	global_position = %MoveProgress.position

func take_damage(damage = 1):
	health -= damage
	%HealthBar.value = health
	if health <= 0:
		killed.emit()
		queue_free()
		const SMOKE_EXPLOSION = preload("res://scenes/smoke_explosion.tscn")
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
