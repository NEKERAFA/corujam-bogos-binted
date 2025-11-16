extends Node2D
var projectile_node = preload("res://scenes/projectile/projectile.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func shoot():
	#TODO change -520 for GLOBAL max depth
	var spawn_y = rng.randi_range(-32, -520)#32 is the height of the projectile, used here to avoid cliping textures
	var projectile : Projectile = projectile_node.instantiate()
	projectile.speed = GameManager.get_velocity()
	add_child(projectile)
	projectile.position = Vector2(980, spawn_y)


func _on_timer_timeout() -> void:
	shoot()
	pass # Replace with function body.
