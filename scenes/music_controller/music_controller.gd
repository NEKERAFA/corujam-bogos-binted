extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.connect("level_music", play_level_music)
	GameManager.connect("button_music", play_button_sound)
	GameManager.connect("movement_sound",play_movement_sound)
	GameManager.connect("jump_sound", play_jump_sound)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func play_level_music():
	$level_music.play()

func play_button_sound():
	$button_music.play(0.0)
	
func play_jump_sound():
	$jump_sound.play()
	
func play_movement_sound():
	#$movement_sound.play()
	pass
