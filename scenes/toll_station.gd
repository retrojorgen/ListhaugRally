extends Node2D
#This node represents a toll booth that covers the entire track width
#if the player does not destroy the camera the toll booth will remove all collected voters from the palyer
@onready var toll_line: CollisionShape2D = $TollLineArea/TollLine
@onready var toll_booth_top: CollisionShape2D = $TollBoothArea/TollBoothTop
@onready var toll_booth_bottom: CollisionShape2D = $TollBoothArea/TollBoothBottom

var camera1Active = true
var can_damage = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _physics_process(delta):
	#print(Global.speed)
	position.x -= Global.speed * delta
	
# this should cause the player to lose all their voters.	
func _on_toll_line_area_body_entered(body: Node2D) -> void:
	#if line lose one voter
	if body.name == "Player" and !Global.is_invincible and can_damage and !Global.is_jumping:
		body.loseAllVoters()
	print("line")
	pass # Replace with function body.


func _on_camera_1_area_area_entered(area: Area2D) -> void:
	if area.name.contains("waffle"):
		$cameras/camera1area/camera1sprite.visible = false
		$cameras/camera1area/camera1explosion.emitting = true
		camera1Active = false
		can_damage = false
		area.queue_free()
	#pass # Replace with function body.


func _on_toll_line_area_area_entered(area: Area2D) -> void:
	if area.name == "StopItems":
		queue_free()
	pass # Replace with function body.
