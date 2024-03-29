# does not exist in collision layer 1 to pass through the player
# no need to worry about passing through walls because it has a strict path to follow
extends CharacterBody2D

# EVERY MOB SHOULD HAVE A KILLED SIGNAL
signal killed

var target
var health = 100
var speed = 15 if State.easy_mode else 25
var speed_up = 5
var speed_up_up = -1
var damage = 5
var child = preload("res://mobs/teleporter.tscn")

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


func _on_timer_timeout():
	speed += speed_up
	speed_up += speed_up_up
	if abs(speed_up) == 5: speed_up_up = -speed_up_up
	var new_child = child.instantiate()
	new_child.global_position = global_position
	new_child.target = target
	get_parent().add_child(new_child)
