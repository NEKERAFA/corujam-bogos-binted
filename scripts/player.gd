extends CharacterBody2D
class_name Worm

const MAX_ANGLE: float = 45
const MAX_SPEED: float = 250.0
const TIME_MAX_SPEED: float = 0.5
const TURN_SPEED: float = 2500.0

@onready var jump_label := %JumpLabel
var worm_part_data := WormPartData.new()
var worm_part = preload("res://scenes/worm/worm_part.tscn")
var worm_array: Array[WormPart] = []
var n_parts: int = 5
var n_frames: int = 6
var offset: float = 28.0
var max_distance: float = 25.0

var min_depth: float = 100.0
var max_depth: float = 500.0
var jump_margin: float = 50.0
var jump_multiplier: float = 2
var is_jumping: bool = false

func _ready() -> void:
	z_index = 1
	jump_label.global_position.y = -100
	var _previous_part_data = worm_part_data
	for n in n_parts:
		var _worm_part: WormPart = worm_part.instantiate()
		worm_array.append(_worm_part)
	
		#get_parent().add_child.call_deferred(_worm_part)
		_worm_part.worm_part_data.previous_part_data = _previous_part_data
		_worm_part.n_frames = n_frames
		_worm_part.max_distance = max_distance
		_worm_part.position.x = position.x - offset * (n+1)
		_worm_part.position.y = position.y
		_previous_part_data = _worm_part.worm_part_data
		
	worm_array.reverse()
	for worm_part in worm_array:
		get_parent().add_child.call_deferred(worm_part)
	worm_array.reverse()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and can_jump():
		is_jumping = true
		start_jump()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if not is_jumping:
		var direction := Input.get_axis("ui_down", "ui_up")
		if direction != 0:
			if direction > 0:
				velocity.y = move_toward(velocity.y, -MAX_SPEED, delta * TURN_SPEED)
			else:
				velocity.y = move_toward(velocity.y, MAX_SPEED, delta * TURN_SPEED)
		else:
			velocity.y = move_toward(velocity.y, 0, delta * TURN_SPEED)
		rotation = deg_to_rad(get_angle())
		global_position.y = clamp(global_position.y, min_depth, max_depth)
		jump_label.visible = can_jump()
	else:
		velocity.y += get_gravity().y * delta
	move_and_slide()
	worm_part_data.positions_array.insert(0, position.y)
	update_worm_parts()

func start_jump() -> void:
	velocity.y = GameManager.movement * jump_multiplier

func can_jump() -> bool:
	return global_position.y <= min_depth + jump_margin

func get_angle() -> float:
	if global_position.y > min_depth and global_position.y < max_depth:
		return (velocity.y * MAX_ANGLE) / MAX_SPEED
	else:
		return 0

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
