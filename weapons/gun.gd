# target layers determined and set in parent
extends Area2D

# re-assigned based on owner/powerup/etc
var bullet = preload("res://weapons/bullet.tscn")
var can_shoot = true
var target
@onready var reload = %Reload


# mask layer to set on every new bullet
# a.k.a. sets the targetable enemies
# bit masks so they count in multiples of 2
# i.e. player is in layer 3 but bitmap 4 so walls(bitmap 1) + player(bitmap 4) = bitmap 5
enum mask {
	player = 5,
	enemy  = 3
}


func shoot():
	if can_shoot:
		can_shoot = false
		var new_bullet = bullet.instantiate()
		new_bullet.global_position = %ShootingPoint.global_position
		new_bullet.global_rotation = %ShootingPoint.global_rotation
		match target:
			"enemy":  new_bullet.collision_mask = mask.enemy
			"player": new_bullet.collision_mask = mask.player
		%ShootingPoint.add_child(new_bullet)
		%Reload.start()


# default reload time of 1s for this weapon
# can be set in parent
func _on_reload_timeout():
	can_shoot = true
