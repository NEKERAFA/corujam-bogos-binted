extends Node

@onready var end_game_menu := $UILayer/EndGameMenu
@onready var pause_menu := $UILayer/PauseMenu

func _ready() -> void:
	GameManager.max_height_reached.connect(_max_height_reached)
	GameManager.game_is_started = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause_input"):
		get_tree().paused= !get_tree().paused
		pause_menu.visible= get_tree().paused
	pass

func _max_height_reached(height: float) -> void:
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
