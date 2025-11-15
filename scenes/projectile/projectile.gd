extends RigidBody2D
class_name Projectile
enum ProjectileTypeEnum {
	ENEMY,
	FRIEND
}
@export var speed:int=1
@export var type:ProjectileTypeEnum = ProjectileTypeEnum.ENEMY

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.set_linear_velocity(Vector2(-speed, 0))
	#TODO meter el sprite en vez de los modulate
	if(1==1):
		#Change sprite to enemy
		print_debug("Enemy")
		$Sprite2D.modulate="#ff0000"
	else:
		#change sprite to friend
		print_debug("Friend")
		$Sprite2D.modulate="#00ff00"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(global_position.x<-100):
		queue_free()
	pass
