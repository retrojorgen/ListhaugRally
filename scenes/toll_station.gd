extends Node2D
@onready var toll_line: CollisionShape2D = $TollLineArea/TollLine
@onready var toll_booth_top: CollisionShape2D = $TollBoothArea/TollBoothTop
@onready var toll_booth_bottom: CollisionShape2D = $TollBoothArea/TollBoothBottom
@onready var toll_top: Sprite2D = $TollTop
@onready var toll_bottom: Sprite2D = $TollBottom

var camera1Active = true
var camera2Active = true
var camera3Active = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var can_damage = true



func _physics_process(delta):
	#print(Global.speed)
	position.x -= Global.speed * delta
	
func _on_toll_line_area_body_entered(body: Node2D) -> void:
	#if line lose one voter
	if body.name == "Player" and !Global.is_invincible and can_damage:
		body.hit()	
	print("line")
	pass # Replace with function body.


func _collisionAnimation():
	if !toll_line.disabled:
		toll_line.disabled = true
		$TollLineArea/TollLine.disabled = true
		$explosionLeft.emitting = true
		$explosionRight.emitting = true
		$TopBars.modulate = Color(3, 3, 3)
		$BaseGraphics.modulate = Color(3, 3, 3)
		$TopBars.visible = false
		$Shadows.visible = false
		$BaseGraphics.visible = false
		#toll_bottom.visible = false
		#await get_tree().create_timer(0.1).timeout
		await get_tree().create_timer(0.3).timeout
		queue_free()



func _isWrecked():
	if !camera1Active and !camera2Active and !camera3Active:
		print("exploding toll booth");
		_collisionAnimation()
	

func _on_camera_1_area_area_entered(area: Area2D) -> void:
	if area.name.contains("waffle"):
		$cameras/camera1area/camera1sprite.visible = false
		$cameras/camera1area/camera1explosion.emitting = true
		camera1Active = false
		_isWrecked()
	#pass # Replace with function body.


func _on_camera_2_area_area_entered(area: Area2D) -> void:
	if area.name.contains("waffle"):
		$cameras/camera2area/camera2sprite.visible = false
		$cameras/camera2area/camera2explosion.emitting = true
		camera2Active = false
		_isWrecked()
	#pass # Replace with function body.


func _on_camera_3_area_area_entered(area: Area2D) -> void:
	if area.name.contains("waffle"):
		$cameras/camera3area/camera3sprite.visible = false
		$cameras/camera3area/camera3explosion.emitting = true
		camera3Active = false
		_isWrecked()
	#pass # Replace with function body.
