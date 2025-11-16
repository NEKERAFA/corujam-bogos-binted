extends Node2D
var projectile_node = preload("res://scenes/projectile/projectile.tscn")
var rng = RandomNumberGenerator.new()
const leave_sprites = [preload("res://assets/art/Props/Items/Leaves/LeafA.tres"),preload("res://assets/art/Props/Items/Leaves/LeafB.tres")]
const rock_sprites = [preload("res://assets/art/Props/Items/Rocks/RockA.tres"),preload("res://assets/art/Props/Items/Rocks/RockB.tres")]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func shoot():
	var spawn_y = rng.randi_range(Globals.min_depth, Globals.max_depth)#32 is the height of the projectile, used here to avoid cliping textures
	var projectile : Projectile = projectile_node.instantiate()
	var type= rng.randi_range(0,1)
	var sprite= rng.randi_range(0,1)
	if(type==0):
		projectile.sprite = leave_sprites[sprite]
		projectile.type= projectile.ProjectileTypeEnum.FRIEND
	else:
		projectile.sprite = rock_sprites[sprite]
		projectile.type= projectile.ProjectileTypeEnum.ENEMY
	
	projectile.speed = GameManager.get_velocity()
	add_child(projectile)
	projectile.position = Vector2(1920, spawn_y)#TODO meter el número en una constante


func _on_timer_timeout() -> void:
	shoot()
	pass # Replace with function body.
