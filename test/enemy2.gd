extends CharacterBody2D

signal killed

func _on_button_pressed():
	killed.emit()
	queue_free()
