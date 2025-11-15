extends CharacterBody2D
class_name Worm

const MAX_ANGLE: float = 45
const MAX_SPEED: float = 250.0
const TIME_MAX_SPEED: float = 0.5
const TURN_SPEED: float = 2500.0

var worm_part_data := WormPartData.new()
var worm_part = preload("res://scenes/worm/worm_part.tscn")
var worm_array: Array[WormPart] = []
var n_parts: int = 5
var n_frames: int = 12
var offset: float = 50.0

func _ready() -> void:
	z_index = 1
	var _previous_part_data = worm_part_data
	for n in n_parts:
		var _worm_part: WormPart = worm_part.instantiate()
		worm_array.append(_worm_part)
	
		#get_parent().add_child.call_deferred(_worm_part)
		_worm_part.worm_part_data.previous_part_data = _previous_part_data
		_worm_part.n_frames = n_frames
		_worm_part.position.x = position.x - offset * (n+1)
		_worm_part.position.y = position.y
		_previous_part_data = _worm_part.worm_part_data
		
	worm_array.reverse()
	for worm_part in worm_array:
		get_parent().add_child.call_deferred(worm_part)
	worm_array.reverse()

func get_angle() -> float:
	return (velocity.y * MAX_ANGLE) / MAX_SPEED

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_down", "ui_up")
	if direction != 0:
		if direction > 0:
			velocity.y = move_toward(velocity.y, -MAX_SPEED, delta * TURN_SPEED)
		else:
			velocity.y = move_toward(velocity.y, MAX_SPEED, delta * TURN_SPEED)
	else:
		velocity.y = move_toward(velocity.y, 0, delta * TURN_SPEED)
	rotation = deg_to_rad(get_angle())
	move_and_slide()
	worm_part_data.positions_array.insert(0, position.y)
	update_worm_parts()

func update_worm_parts() -> void:
	for _worm_part in worm_array:
		_worm_part.update_position()

#func velocity_accel(vertical_velocity: float, target_speed: float, delta: float) -> float:
	#var t = abs(vertical_velocity / target_speed)
	#if is_nan(t):
		#t = 1
	#var t_new: float = t + (delta / TIME_MAX_SPEED)
	#var new_speed: float = clamp(t_new, 0, 1) * target_speed
	#return target_direction * new_speed
