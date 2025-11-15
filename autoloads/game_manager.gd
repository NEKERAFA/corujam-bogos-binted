extends Node


var movement: int = -128


func get_velocity() -> Vector2:
	return Vector2.RIGHT * float(movement)
