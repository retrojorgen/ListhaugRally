extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x -= Global.speed * delta
	#pass


#func _on_area_2d_body_entered(body: Node2D) -> void:
#	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and !Global.is_invincible and !Global.is_jumping:		
		body.instantKill()
		emit_signal("obstacle")
	pass # Replace with function body.


func _on_area_entered(area: Area2D) -> void:
	if area.name == "StopItems":
		queue_free()
	pass # Replace with function body.
