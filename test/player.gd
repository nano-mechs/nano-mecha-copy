extends CharacterBody2D

signal killed

func _physics_process(delta):
	velocity = 600 * Input.get_vector("move_left", "move_right", "move_up", "move_down")
	move_and_slide()
