extends Control
@export var distance: float = 0.0
@export var height: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Panel/VBoxContainer/HBoxContainer/Label2.text = "%.2f m" % (distance / 100.0)
	$Panel/VBoxContainer/HBoxContainer2/Label2.text = "%.2f m" % (-height / 100.0)
	pass


func _on_button_pressed() -> void:
	GameManager.button_music.emit()
	GameManager.reset()
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
	pass # Replace with function body.
