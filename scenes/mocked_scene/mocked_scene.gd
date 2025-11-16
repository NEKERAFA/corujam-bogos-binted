extends Node
var projectile_node = preload("res://scenes/projectile/projectile.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	$AnimationPlayer.play("yuhu_animation")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
