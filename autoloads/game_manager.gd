extends Node

## Player signal reemitted when max height is reached
signal max_height_reached(height: float)
signal movement_changed(new_movement : Vector2)
signal level_music()
signal button_music()
signal movement_sound()
signal jump_sound()
signal eat_sound()
signal hit_sound()
signal main_menu_music()
const MOVEMENT_INCREASE : int = 100
const MIN_MOVEMENT:int=-100
const STARTING_MOVEMENT:int = -200
var movement := STARTING_MOVEMENT
var distance_traveled: float = 0.0
var player: CharacterBody2D
var player_is_jumping: bool = false
var game_is_started: bool = false
const MAX_MOVEMENT :int = MIN_MOVEMENT*20

func _process(delta: float) -> void:
	if not player_is_jumping and game_is_started:
		distance_traveled += abs(movement * delta)

func reset() -> void:
	distance_traveled = 0.0
	movement = STARTING_MOVEMENT
	player_is_jumping = false
	game_is_started = false

func set_player(_player: CharacterBody2D) -> void:
	player = _player
	player.jumped.connect(player_jumped)
	player.max_height_reached.connect(func (height): max_height_reached.emit(height))

func player_jumped() -> void:
	player_is_jumping = true

func get_velocity() -> Vector2:
	return Vector2.RIGHT * float(movement)

func upgrade_movement():
	movement = clamp(movement-MOVEMENT_INCREASE,MAX_MOVEMENT, MIN_MOVEMENT )
	movement_changed.emit(get_velocity())
	
func downgrade_movement():
	movement = clamp(movement+MOVEMENT_INCREASE,MAX_MOVEMENT,MIN_MOVEMENT )
	movement_changed.emit(get_velocity())
