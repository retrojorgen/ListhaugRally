extends Area2D
@onready var obstacle_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

var can_damage = true

signal obstacle

func _process(delta):
	global_position.x -= (Global.speed + 100) * delta






#func _on_area_entered(area: Area2D):
#	print("yo")
#	if area.name == "StopItems":
#		queue_free()
#		
#func _on_body_entered(body):
#	if body.name == "Player":
#		print("Collision with player!")
#		queue_free()  # or trigger game over


func _on_body_entered(body: Node2D) -> void:
	
	if body.name == "Player" and can_damage and !Global.is_invincible and !Global.is_jumping:		
		body.hit()
		emit_signal("obstacle")
	#print(body.name)
		#queue_free()  # or trigger game over

# hits the end of the screen
func _on_area_entered(area: Area2D) -> void:
	#print(area.name)
	if area.name.contains("waffle") and can_damage:
		hit()
		area.queue_free()
	if area.name == "StopItems":
		queue_free()


func hit():
	# Gjør bilen hvit
	if !collision_shape_2d.disabled:
		can_damage = false
		cpu_particles_2d.emitting = true
		collision_shape_2d.disabled = true
		obstacle_sprite.modulate = Color(3, 3, 3)
	
		# Beveg litt bakover
		var knockback_distance := -50
		var knockback_speed := -500.0
		var target_position := position - Vector2(knockback_distance, 0)

		# Bruk tween for smooth bevegelse
		var tween := create_tween()
		tween.tween_property(self, "position", target_position, knockback_distance / knockback_speed)
		tween.tween_callback(Callable(func(): 
			obstacle_sprite.visible = false		
		))
		await get_tree().create_timer(0.3).timeout
		queue_free()
	
