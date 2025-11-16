extends Node2D
class_name WormPart

var worm_part_data := WormPartData.new()
var n_frames: int
var max_distance: float
var max_rotation: float

func update_position() -> void:
	if len(worm_part_data.previous_part_data.positions_array) >= n_frames:
		var part_position: float = worm_part_data.previous_part_data.positions_array.pop_back()
		var part_rotation: float = worm_part_data.previous_part_data.rotations_array.pop_back()
		var first_position: float = worm_part_data.previous_part_data.positions_array.front()
		part_position = clamp(part_position, first_position-max_distance, first_position+max_distance)
		part_rotation = clamp(part_rotation, -max_rotation, max_rotation)
		worm_part_data.positions_array.insert(0, part_position)
		worm_part_data.rotations_array.insert(0, part_rotation)
		position.y = part_position
		rotation = part_rotation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
