extends Line2D

@export
var player: Node2D = null


func _ready() -> void:
	if player != null:
		var player_head = player.get_node('Player')
		for point_idx in range(points.size()):
			var point_pos = Vector2(
				player_head.global_position.x - Globals.offset * Globals.n_parts - Globals.offset / Globals.n_frames * (point_idx+1),
				player_head.global_position.y
			)
			points[point_idx] = point_pos

		#_worm_part.n_frames = Globals.n_frames
		#_worm_part.max_distance = Globals.max_distance
		#_worm_part.max_rotation = Globals.max_rotation
		#_worm_part.position.x = position.x - Globals.offset * (n+1)
		#_worm_part.position.y = position.y


func _physics_process(_delta: float) -> void:
	if player != null:
		var tail_player = (player.get_node('Player') as Worm).worm_array.back().global_position.y
		if tail_player > 0:
			points[0].y = tail_player
			for point_idx in range(points.size() - 1, 0, -1):
				points[point_idx].y = points[point_idx - 1].y

		#var first_position: float = worm_part_data.previous_part_data.positions_array.front()
		#part_position = clamp(part_position, first_position-max_distance, first_position+max_distance)
		#position.y = part_position
