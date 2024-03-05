# exists in collision layer 1 and 3 to interact with walls and enemies
# mask layer for attacking enemies determined by weapon targets
# hurtbox mask layer looks for collisions in layer 2 where only enemies are
extends CharacterBody2D

signal killed

var health = 100
const base_speed       = 1000
const base_reload_time = 0.2
const base_bullet      = preload("res://weapons/bullet.tscn")
var speed       = base_speed
var bullet      = base_bullet


func _ready():
	%Gun.reload.wait_time = base_reload_time
	%Gun.target = "enemy"


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
	if Input.is_action_pressed("shoot"):
		%Gun.shoot(bullet)


func take_damage(damage = 1):
	health -= damage
	%HealthBar.value = health
	if health <= 0:
		killed.emit()


func get_status(stats):
	if stats.speed:       speed                 = stats.speed
	if stats.reload_time: %Gun.reload.wait_time = stats.reload_time
	if stats.bullet:      bullet                = stats.bullet

	%StatusTimer.wait_time = stats.wait_time
	%StatusTimer.start() # also refreshes status time when new status get


# revert changed stats when powerup timer runs out
func _on_status_timer_timeout():
	speed  = base_speed
	bullet = base_bullet
	%Gun.reload.wait_time = base_reload_time
