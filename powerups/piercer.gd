extends StaticBody2D

var target

# no need to check which body touches the powerup because
# only the player is in collision layer 4
func _on_area_2d_body_entered(body):
	target.get_status({
		"speed": 0,
		"reload_time": 0.1,
		"bullet": preload("res://weapons/piercer.tscn")
	})
	queue_free()
