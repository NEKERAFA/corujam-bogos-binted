extends CharacterBody2D

const MAX_ANGLE: float = 45
const MAX_SPEED: float = 10.0
const SPEED = 300.0

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_down", "ui_up")
	if direction != 0:
		if direction:
			velocity.y = move_toward(velocity.y, MAX_SPEED, SPEED)
		else:
			velocity.y = move_toward(velocity.y, -MAX_SPEED, SPEED)
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
