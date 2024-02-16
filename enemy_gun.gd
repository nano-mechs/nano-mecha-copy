extends Area2D

@onready var player = get_node("/root/Game/Player")

var can_shoot = true 

func _physics_process(delta: float ) -> void:
	look_at(player.global_position)

func shoot():
	const BULLET = preload("res://scenes/enemy_bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position =%ShootingPoint.global_position
	new_bullet.global_rotation =%ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)
	
func _on_can_shoot_timeout():
	shoot()
