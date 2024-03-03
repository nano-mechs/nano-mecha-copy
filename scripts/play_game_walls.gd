# walls exist in layers 1 2 3 to interact with anything and everything
extends StaticBody2D

# removes problem with player asking for damage on wall contact
var damage = 0
# removes the need for an if check when a bullet hits a wall
func take_damage(_damage = null):
	pass
