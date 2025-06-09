extends Area2D
#for now we only have invinsible powerup
#@export var speed := 200
signal powerup
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x -= Global.speed * delta  
	#pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		#body.flash()
		
		body.powerUp()
		emit_signal("powerup")
	#pass # Replace with function body.
