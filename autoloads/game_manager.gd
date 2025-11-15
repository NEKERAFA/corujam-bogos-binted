extends Node


var movement: int = -1000#-128


func get_velocity() -> Vector2:
	return Vector2.RIGHT * float(movement)
