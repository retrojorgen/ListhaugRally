extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	name = "waffle"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += 400 * delta
	


func _on_area_entered(area: Area2D) -> void:
	if area.name == "StopItemsRight":
		queue_free()
