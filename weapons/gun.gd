extends Area2D

# re-assigned based on owner/powerup/etc
var bullet = preload("res://weapons/bullet.tscn")
var can_shoot = true
var target
@onready var reload = %Reload

# for setting the target
enum mask {
	player = 4, # shows up as collision mask 3 on the gui but it's 4 as a bit mask
	mob = 2
}

func shoot():
	if can_shoot:
		can_shoot = false
		var new_bullet = bullet.instantiate()
		new_bullet.global_position = %ShootingPoint.global_position
		new_bullet.global_rotation = %ShootingPoint.global_rotation
		match target:
			"mob":    new_bullet.collision_mask = mask.mob
			"player": new_bullet.collision_mask = mask.player
		%ShootingPoint.add_child(new_bullet)
		%Reload.start()


func _on_reload_timeout():
	can_shoot = true
