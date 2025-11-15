extends CanvasLayer


func _process(_delta: float) -> void:
	$Sky.autoscroll.x = GameManager.movement / 4.0
	$Ground.autoscroll.x = GameManager.movement
	$Underground.autoscroll.x = GameManager.movement
