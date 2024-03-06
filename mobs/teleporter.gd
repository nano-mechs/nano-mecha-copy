
extends CharacterBody2D

signal killed

var target
var health   = 2
var speed    = 500
var damage   = 1
var tp_range = 350 # Adjust as needed
# TODO teleport animation or something
# var tp_flash = preload(new teleport visuals scene)

var play_area_width = 1920 * 2;
var play_area_height = 1080 * 2;


func teleport():
	# TODO teleport animation or something
	# var tp = tp_flash.instantiate()
	# tp.global_position = global_position
	# get_parent().add_child(tp)

	# teleports within set distance of original spot
	var tp_position = Vector2(randf_range(-tp_range, tp_range),
							  randf_range(-tp_range, tp_range))
	global_position += tp_position
	# keep this thing within bounds
	if global_position.x > play_area_width:
		global_position.x -= play_area_width
	elif global_position.x < 0:
		global_position.x += play_area_width
	if global_position.y > play_area_height:
		global_position.y -= play_area_height
	elif global_position.y < 0:
		global_position.y += play_area_height


func _physics_process(delta):
	var direction = global_position.direction_to(target.global_position)
	velocity = direction * speed

	if velocity.x < 0: %AnimatedSprite2D.flip_h = true
	else: %AnimatedSprite2D.flip_h = false
	move_and_slide()


func take_damage(damage = 1):
	health -= damage
	if health <= 0:
		killed.emit(global_position)
		queue_free()
		const SMOKE_EXPLOSION = preload("res://scenes/smoke_explosion.tscn")
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
	# teleport after getting hit
	teleport()


func _on_timer_timeout():
	teleport()
