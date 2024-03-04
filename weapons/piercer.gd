extends Area2D

var speed = 3000
var damage = 2


func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta


func _on_body_entered(body):
	# the only StaticBody2D in use atm are the walls so it's fine for now
	if body is StaticBody2D:
		queue_free()
	body.take_damage(damage)
