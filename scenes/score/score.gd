extends HBoxContainer
class_name Score


@onready var _name_lbl = $Name
@onready var _points_lbl = $Points


func set_score(player: String, points: float) -> void:
	set_player(player)
	set_points(points)


func set_player(player: String) -> void:
	_name_lbl.text = player


func set_points(points: float) -> void:
	_points_lbl.text = "%.2f cm" % (points / 100)
