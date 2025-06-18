extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var r = randi_range(1, 10)
	match r:
		1:
			$Collection1.visible = true
		2:
			$Collection2.visible = true
		3:
			$Collection3.visible = true
		4:
			$Collection4.visible = true
		5:	
			$Collection5.visible = true
		6:	
			$Collection6.visible = true	
		7:	
			$Collection7.visible = true
		8:	
			$Collection8.visible = true	
		9:	
			$Collection9.visible = true	
		10:	
			$Collection10.visible = true	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x -= Global.speed * delta
	pass
