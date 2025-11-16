extends Line2D

@export
var player: Node2D = null

var player_is_jumped = false


func _ready() -> void:
	if player != null:
		var player_head = player.get_node('Player') as Worm
		for point_idx in range(points.size()):
			var point_pos = Vector2(
				player_head.global_position.x - Globals.offset * Globals.n_parts - Globals.offset / Globals.n_frames * (point_idx+1),
				player_head.global_position.y
			)
			points[point_idx] = point_pos

		player_head.jumped.connect(_on_player_jumped)


func _physics_process(_delta: float) -> void:
	if player != null:
		var tail_player = (player.get_node('Player') as Worm).worm_array.back().global_position.y
		if tail_player > 0:
			points[0].y = tail_player
			for point_idx in range(points.size() - 1, 0, -1):
				points[point_idx].y = points[point_idx - 1].y
		elif player_is_jumped:
			for point_idx in range(points.size() - 1, -1, -1):
				points[point_idx].x += GameManager.movement


func _on_player_jumped():
	player_is_jumped = true
