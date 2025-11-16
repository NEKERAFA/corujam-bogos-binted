extends Control


const MAX_SCORES = 5
const _score_scn = preload("res://scenes/score/score.tscn")


var _config = ConfigFile.new()
var _height = 0.0

@onready
var player_input := $Panel/VBoxContainer2/VBoxContainer/HBoxContainer/TextEdit


func _ready() -> void:
	var scores = MAX_SCORES
	if _config.load("user://scores.cfg") == OK:
		var ranking = []
		for player in _config.get_sections():
			ranking.append({
				player = player,
				points = float(_config.get_value(player, "points"))
			})
		ranking.sort_custom(func(a, b): return a.score > b.score)

		for score in ranking:
			if scores == 0:
				continue

			var score_lbl: Score = _score_scn.instantiate()
			$Panel/VBoxContainer2/ScoreContainer.add_child(score_lbl)
			score_lbl.set_score(score.player, score.points)
			scores -= 1
		
	for x in range(scores):
		var score_lbl: Score = _score_scn.instantiate()
		$Panel/VBoxContainer2/ScoreContainer.add_child(score_lbl)
		score_lbl.set_score("-", 0)


func set_height(height: float) -> void:
	_height = -height
	$Panel/VBoxContainer2/VBoxContainer/HBoxContainer2/Label2.text = "%.2f cm" % (_height / 100)


func _on_button_pressed() -> void:
	var player : String = player_input.text.strip_edges()
	if player.is_empty():
		player = "Gusanito"
	
	_config.set_value(player, "points", _height)
	_config.save("user://scores.cfg")
	GameManager.button_music.emit()
	GameManager.reset()
	get_tree().change_scene_to_file('res://scenes/main_menu/main_menu.tscn')
