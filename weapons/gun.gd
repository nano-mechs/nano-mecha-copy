extends Area2D

var bullet = preload("res://weapons/bullet.tscn")

func shoot():
	var new_bullet = bullet.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	%ShootingPoint.add_child(new_bullet)
