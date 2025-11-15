extends CharacterBody2D

const MAX_ANGLE: float = 45
const MAX_SPEED: float = 200.0
const TIME_MAX_SPEED: float = 0.5
const TURN_SPEED: float = 2500.0

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

	move_and_slide()

#func velocity_accel(vertical_velocity: float, target_speed: float, delta: float) -> float:
	#var t = abs(vertical_velocity / target_speed)
	#if is_nan(t):
		#t = 1
	#var t_new: float = t + (delta / TIME_MAX_SPEED)
	#var new_speed: float = clamp(t_new, 0, 1) * target_speed
	#return target_direction * new_speed
