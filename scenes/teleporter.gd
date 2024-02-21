extends CharacterBody2D

var health = 1

@onready var player = get_node("/root/Game/Player")


var play_area_width = 1920 * 2;
var play_area_height = 1080 * 2;

var teleportTimer = 0
var teleportInterval = 1 # Adjust as needed
var teleportDistance = 350 # Adjust as needed

func _process(delta):
	teleportTimer += delta
	if teleportTimer >= teleportInterval:
		teleport()
		teleportTimer = 0

func teleport():
#	#teleports within set distance of original spot
	var rand_pos = Vector2(randf_range(-teleportDistance, teleportDistance), randf_range(-teleportDistance, teleportDistance))
	#for fixed distance within play area#
	#var rand_pos = Vector2(play_area_width * randf(), play_area_height * randf()) 
	global_position += rand_pos


func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()

func take_damage():
	health -= 1
	if health == 0:
		queue_free()
		const SMOKE_EXPLOSION = preload("res://scenes/smoke_explosion.tscn")
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
