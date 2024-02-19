extends CharacterBody2D

signal killed

# stats
var health = 100.0
# TODO: move this to each mob to make their damage unique
const DAMAGE_RATE = 50.0

# runs 60 times per second
# movement etc etc
func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()

	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
	if health <= 0.0:
		killed.emit()

	%Gun.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Shoot"):
		%Gun.shoot()

func take_damage():
	health -= 5
	%ProgressBar.value = health
	if health <= 0.0:
		killed.emit()
