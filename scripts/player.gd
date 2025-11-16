extends CharacterBody2D
class_name Worm

## Signal emitted when player starts the jump
signal jumped
## Signal emitted when player reaches max height
signal max_height_reached(height: float)

const MAX_ANGLE: float = 45
const MAX_SPEED: float = 250.0
const TIME_MAX_SPEED: float = 0.5
const TURN_SPEED: float = 2500.0

@onready var jump_label := %JumpLabel
var worm_part_data := WormPartData.new()
var worm_part_scene = preload("res://scenes/worm/worm_part.tscn")
var worm_array: Array[WormPart] = []


## Margin for the jump button prompt to appear
var jump_margin: float = 50.0
## Movement speed multiplier when jumping
var jump_multiplier: float = 3

var is_jumping: bool = false
var started_falling: bool = false

func _ready() -> void:
	z_index = 1
	jump_label.global_position.y = -100
	var _previous_part_data = worm_part_data
	for n in Globals.n_parts:
		var _worm_part: WormPart = worm_part_scene.instantiate()
		worm_array.append(_worm_part)
		_worm_part.worm_part_data.previous_part_data = _previous_part_data
		_worm_part.n_frames = Globals.n_frames
		_worm_part.max_distance = Globals.max_distance
		_worm_part.max_rotation = Globals.max_rotation
		_worm_part.position.x = position.x - Globals.offset * (n+1)
		_worm_part.position.y = position.y
		_previous_part_data = _worm_part.worm_part_data
	
	worm_array.reverse()
	for worm_part in worm_array:
		get_parent().add_child.call_deferred(worm_part)
	worm_array.reverse()
	GameManager.set_player(self)

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
		global_position.y = clamp(global_position.y, Globals.min_depth, Globals.max_depth)
		jump_label.visible = can_jump()
	else:
		# Check if the player has reached maximum height to stop the camera
		if velocity.y > 0:
			if not started_falling:
				started_falling = true
				max_height_reached.emit(global_position.y)
				get_viewport().get_camera_2d().player = null
		velocity.y += get_gravity().y * delta
		rotation = deg_to_rad(get_angle())
		global_position.y = min(global_position.y, Globals.max_depth)
	move_and_slide()
	worm_part_data.positions_array.insert(0, position.y)
	worm_part_data.rotations_array.insert(0, rotation)
	update_worm_parts()

func start_jump() -> void:
	jumped.emit()
	velocity.y = GameManager.movement * jump_multiplier

func can_jump() -> bool:
	return global_position.y <= Globals.min_depth + jump_margin

func get_angle() -> float:
	## TODO: head rotation when jumping: bug or feature?
	if is_jumping or (global_position.y > Globals.min_depth and global_position.y < Globals.max_depth):
		return (velocity.y * MAX_ANGLE) / MAX_SPEED
	else:
		return 0

func update_worm_parts() -> void:
	for _worm_part in worm_array:
		_worm_part.update_position()
