extends Camera2D


@export
var player: Node2D
@export
var player_height := 64


func _ready() -> void:
	limit_bottom = int(Globals.max_depth) + player_height / 2


func _process(_delta: float) -> void:
	if player != null:
		position = player.get_node('Player').global_position
