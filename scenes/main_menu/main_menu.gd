extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/Button2.visible = !OS.has_feature("web")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	#change scene
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	$Label.text="a pos te quedas sin jugar"
	$VBoxContainer/Button.visible=false
	$VBoxContainer/Button2.visible=false
	$VBoxContainer/Button3.visible=true
	$VBoxContainer/Button4.visible=true
	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	$Label.text="¿Me querrías si fuese un gusanito?"
	$VBoxContainer/Button.visible=true
	$VBoxContainer/Button2.visible=true
	$VBoxContainer/Button3.visible=false
	$VBoxContainer/Button4.visible=false
	pass # Replace with function body.


func _on_button_4_pressed() -> void:
	#exit game
	get_tree().quit()
	pass # Replace with function body.
