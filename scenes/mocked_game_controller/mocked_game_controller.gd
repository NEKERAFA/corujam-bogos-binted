extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("yuhu_animation")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause_input"):
		get_tree().paused= !get_tree().paused
		$PauseMenu.visible= get_tree().paused
	pass
