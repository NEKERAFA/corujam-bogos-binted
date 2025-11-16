extends Control
@export var distance:int=0
@export var height:int=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Panel/VBoxContainer/HBoxContainer/Label2.text = str(distance)
	$Panel/VBoxContainer/HBoxContainer2/Label2.text = str(height)
	pass


func _on_button_pressed() -> void:
	GameManager.button_music.emit()
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
	pass # Replace with function body.
