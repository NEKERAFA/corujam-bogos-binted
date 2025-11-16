extends Node

@onready var end_game_menu := $UILayer/EndGameMenu
@onready var pause_menu := $UILayer/PauseMenu

@export
var player: Node2D = null


func _ready() -> void:
	$UILayer/Control/TutorialAnimation.play("tutorial")
	GameManager.game_is_started = true
	GameManager.max_height_reached.connect(_on_max_height_reached)
	GameManager.level_music.emit()
	GameManager.movement_sound.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause_input"):
		GameManager.level_music.emit(get_tree().paused)
		get_tree().paused= !get_tree().paused
		pause_menu.visible= get_tree().paused
	pass


func _on_max_height_reached(height: float) -> void:
	if player != null and not %HeightMark.visible:
		%HeightMark.position.x = player.get_node('Player').global_position.x - 64
		%HeightMark.position.y = height
		%HeightMark.show()
		%HeightMark.get_node("HeightLabel").text = "%d cm" % (-height)
	end_game_menu.height = height
	end_game_menu.distance = GameManager.distance_traveled
	var timer_to_end := Timer.new()
	add_child(timer_to_end)
	timer_to_end.wait_time = 1.5
	timer_to_end.one_shot = true
	timer_to_end.timeout.connect(_open_end_menu)
	timer_to_end.start()

func _open_end_menu():
	end_game_menu.visible = true
