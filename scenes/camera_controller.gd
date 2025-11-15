extends Camera2D


func _process(delta: float) -> void:
	if Input.is_action_pressed('ui_up'):
		position.y -= 128 * delta
	elif Input.is_action_pressed('ui_down'):
		position.y += 128 * delta
