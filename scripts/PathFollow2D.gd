extends PathFollow2D
var runSpeed = 1300

func _process(delta):
	set_progress(get_progress() + runSpeed * delta)
