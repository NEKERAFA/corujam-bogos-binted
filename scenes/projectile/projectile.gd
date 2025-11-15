extends RigidBody2D
class_name Projectile

@export var speed:int=1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.set_linear_velocity(Vector2(-speed, 0))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
