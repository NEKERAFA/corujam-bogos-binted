extends Node

## Player signal reemitted when max height is reached
signal max_height_reached(height: float)
signal movement_changed(new_movement : Vector2)
const MOVEMENT_INCREASE : int = 100
const MIN_MOVEMENT:int=-100
var movement: int = -500#-128
var distance_traveled: float = 0.0
var player: CharacterBody2D
var player_is_jumping: bool = false
var game_is_started: bool = false

func _process(delta: float) -> void:
	if not player_is_jumping and game_is_started:
		distance_traveled += abs(movement * delta)

func set_player(_player: CharacterBody2D) -> void:
	player = _player
	player.jumped.connect(player_jumped)
	player.max_height_reached.connect(func (height): max_height_reached.emit(height))

func player_jumped() -> void:
	player_is_jumping = true

func get_velocity() -> Vector2:
	return Vector2.RIGHT * float(movement)

func upgrade_movement():
	movement = clamp(movement-MOVEMENT_INCREASE,MIN_MOVEMENT*10, MIN_MOVEMENT )
	movement_changed.emit(get_velocity())
	
func downgrade_movement():
	movement = clamp(movement+MOVEMENT_INCREASE, MIN_MOVEMENT*10,MIN_MOVEMENT )
	movement_changed.emit(get_velocity())
