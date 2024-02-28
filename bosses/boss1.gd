extends CharacterBody2D
# EVERY MOB SHOULD HAVE A KILLED SIGNAL
signal killed
var health = 100

func take_damage(damage = 5):
	health -= damage
	%BossHealth.value = health
	if health <= 0:
		killed.emit()
		queue_free()
		const SMOKE_EXPLOSION = preload("res://scenes/smoke_explosion.tscn")
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
