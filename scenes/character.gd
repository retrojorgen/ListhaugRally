extends Area2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var speed :=200.0
var float_after_character_ready = false
signal character
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x -= Global.speed * delta

	
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and !float_after_character_ready:
		emit_signal("character")
		body.itemHit()
		queue_free()
	#pass # Replace with function body.


func float():
	print("hello")
	collision_shape_2d.disabled = false
	$AnimationPlayer.play("float")
	$AnimationPlayer.play("float")
	
	
func _on_area_entered(area: Area2D) -> void:
	# remove from scene if it passed through
	if area.name == "StopItems":
		queue_free()
	#pass # Replace with function body.
