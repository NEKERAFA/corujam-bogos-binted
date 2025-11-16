extends RigidBody2D
class_name Projectile

enum ProjectileTypeEnum {
	ENEMY,
	FRIEND
}

@export var speed:Vector2
@export var type:ProjectileTypeEnum = ProjectileTypeEnum.ENEMY
@export var sprite:SpriteFrames
var has_broken=false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.sprite_frames=sprite
	self.set_linear_velocity(speed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.set_linear_velocity(GameManager.get_velocity())
	if(global_position.x<-100):
		queue_free()
	pass


func _on_body_entered(body: Node) -> void:
	if(!has_broken):
		has_broken=true
		self.set_freeze_enabled.call_deferred(true)
		$AnimatedSprite2D.play("break")
		
		match type:
			ProjectileTypeEnum.ENEMY:
				(body as Worm).hit()
				GameManager.hit_sound.emit()
			ProjectileTypeEnum.FRIEND:
				(body as Worm).eat()
				GameManager.eat_sound.emit()


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation=="break" :
		if type==ProjectileTypeEnum.ENEMY:
			GameManager.downgrade_movement()
		else:
			GameManager.upgrade_movement()
			
		queue_free()
