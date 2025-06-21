extends Area2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

#@export var speed :=200.0
var float_after_character_ready = false
var move_toggle = false
signal character
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !move_toggle:
		global_position.x -= Global.speed * delta

	
func _ready():
	randomize()
	var random_number = randi_range(1, 2)
	if random_number == 2:
		$AnimatedSprite2D.play("dude")

			
func _on_body_entered(body: Node2D) -> void:
	#print("hello")
	if body.name == "Player" and !float_after_character_ready:
		emit_signal("character")	
		body.voterCollision()
		queue_free()
	#pass # Replace with function body.

func disable():
	visible = false
	move_toggle = true
	collision_shape_2d.disabled = true


func enable():
	visible = true
	collision_shape_2d.disabled = false
	
func float():
	#print("hello")
	collision_shape_2d.disabled = false
	$AnimationPlayer.play("float")
	
	
func _on_area_entered(area: Area2D) -> void:
	# remove from scene if it passed through
	if area.name == "StopItems":
		queue_free()
	#pass # Replace with function body.
