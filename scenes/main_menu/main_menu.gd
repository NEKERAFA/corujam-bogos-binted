extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FirstScreen/BoxContainer/Start/VBoxContainer/No.visible = !OS.has_feature("web")


func _on_button_pressed() -> void:
	#change scene
	GameManager.button_music.emit()
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")


func _on_button_2_pressed() -> void:
	$FirstScreen.hide()
	$SecondScreen.show()


func _on_button_3_pressed() -> void:
	$FirstScreen.show()
	$SecondScreen.hide()


func _on_button_4_pressed() -> void:
	get_tree().quit()
