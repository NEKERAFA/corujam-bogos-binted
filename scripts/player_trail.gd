extends Line2D

@export
var player: Node2D = null


func _ready() -> void:
	if player != null:
		for point_idx in range(points.size()):
			points[point_idx].x = -100
			points[point_idx].y = 800


func _physics_process(_delta: float) -> void:
	if player != null:
		points[0] = (player.get_node('Player') as Worm).worm_array.back().global_position
		for point_idx in range(points.size() - 1, 0, -1):
			points[point_idx] = points[point_idx - 1]
			points[point_idx].x += GameManager.movement * _delta
