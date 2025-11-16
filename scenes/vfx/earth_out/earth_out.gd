extends AnimatedSprite2D


func _on_animation_finished() -> void:
	hide()


func _on_visibility_changed() -> void:
	if visible:
		play("earth_out")
