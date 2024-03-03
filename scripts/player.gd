# exists in collision layer 1 and 3 to interact with walls and enemies
# mask layer for attacking enemies determined by weapon targets
# hurtbox mask layer looks for collisions in layer 2 where only enemies are
extends CharacterBody2D

signal killed
var reload_time = 0.4
var health = 100
var speed  = 1000

func _ready():
	%Gun.reload.wait_time = reload_time
	%Gun.target = "mob"

# runs 60 times per second
func _physics_process(delta):
	# move direction & speed
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()

	# check for contact with enemies and receive damage
	var overlapping_enemies = %HurtBox.get_overlapping_bodies()
	for enemy in overlapping_enemies:
		take_damage(enemy.damage)

	# weapon
	%Gun.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Shoot"):
		%Gun.shoot()

func take_damage(damage = 1):
	health -= damage
	%HealthBar.value = health
	if health <= 0:
		killed.emit()
