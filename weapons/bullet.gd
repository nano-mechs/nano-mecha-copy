extends Area2D

var travelled_distance = 0
var speed = 1000
var range = 1200
var damage = 1

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta

	travelled_distance += speed * delta
	if travelled_distance > range:
		queue_free()


func _on_body_entered(body):
	queue_free()
	body.take_damage(damage)
