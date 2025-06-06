extends CharacterBody2D
@onready var car_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
const WAFFLE = preload("res://scenes/waffle.tscn")
const VOTER = preload("res://scenes/character.tscn")
@onready var explosion: CPUParticles2D = $explosion

@onready var sprite_2d: Sprite2D = $Sprite2D



const SPEED = 300.0
const JUMP_VELOCITY = -600.0
var gravity := 400.0
var is_jumping := false
var jump_origin_y := 0.0
var jump_height := 50.0
var jump_speed := 200.0
var going_up := true
@onready var jumpSound: AudioStreamPlayer = $Sounds/jump
@onready var explosionSound: AudioStreamPlayer = $Sounds/explosion
@onready var powerupSound: AudioStreamPlayer = $Sounds/powerup
@onready var hurtSound: AudioStreamPlayer = $Sounds/hurt
@onready var coinSound: AudioStreamPlayer = $Sounds/coin



func _ready():
	Sounds.listhaug_bil.play()

func spawn_waffle():
	#print("spawning obstacle")
	var waffleInstance = WAFFLE.instantiate()
	
	waffleInstance.global_position = Vector2(position.x, position.y);
	get_node("/root/Game").add_child(waffleInstance)
	Sounds.powerup.play()
	

func flash():
	Global.is_invincible = true
	var blinking := true

	# Timer for blinking
	var blink_timer := Timer.new()
	blink_timer.wait_time = 0.15
	blink_timer.one_shot = false
	add_child(blink_timer)

	blink_timer.timeout.connect(func():
		if car_sprite.modulate.a > 0.5:
			car_sprite.modulate.a = 0.2
			sprite_2d.modulate.a = 0.2
		else:
			car_sprite.modulate.a = 1.0
			sprite_2d.modulate.a = 1.0
	)

	blink_timer.start()

	# Timer for å stoppe etter 6 sekunder
	await get_tree().create_timer(2.0).timeout

	blink_timer.stop()
	blink_timer.queue_free()
	car_sprite.modulate.a = 1.0
	sprite_2d.modulate.a = 1.0
	Global.is_invincible = false
	
		
func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	
	
	
	
	
	
	
	
	
	

		
	if(Input.is_action_just_pressed("shoot")):
		spawn_waffle()
			

	direction = direction.normalized()
	velocity = direction * SPEED
	
		# Start hopp hvis på "bakken" og trykker knapp
		# Start hopp
	if Input.is_action_just_pressed("ui_accept") and not is_jumping:
		Sounds.jump.play()
		is_jumping = true
		collision_shape_2d.disabled = true 
		going_up = true
		jump_origin_y = car_sprite.position.y

	# Flytt kun sprite opp og ned
	if is_jumping:
		if going_up:
			car_sprite.position.y -= jump_speed * delta
			if car_sprite.position.y <= jump_origin_y - jump_height:
				going_up = false
				
		else:
			car_sprite.position.y += jump_speed * delta
			if car_sprite.position.y >= jump_origin_y:
				car_sprite.position.y = jump_origin_y
				is_jumping = false
				collision_shape_2d.disabled = false
	
	
	move_and_slide()

	# Clamp position within the screen bounds
	var screen_size = get_viewport_rect().size
	
	
	if position.x < Global.LEFT_OF_TRACK:
		position.x = Global.LEFT_OF_TRACK;
	if position.x > Global.RIGHT_OF_TRACK:
		position.x = Global.RIGHT_OF_TRACK;
	if position.y < Global.TOP_OF_TRACK:
		position.y = Global.TOP_OF_TRACK;
	if position.y > Global.BOTTOM_OF_TRACK:
		position.y = Global.BOTTOM_OF_TRACK;
		

func loseVoters(numberOfVoters = 1):
		#print("spawning obstacle")
	
	#print("got here");
	#var voterInstance = VOTER.instantiate()
	#voterInstance.global_position = Vector2(position.x, position.y)
	#get_node("/root/Game").add_child(voterInstance)
	#voterInstance.float()
	for i in range(1, numberOfVoters+1):
		var character = preload("res://scenes/character.tscn").instantiate()
		#print(position.x, position.y)
		character.scale.x = 3;
		character.float_after_character_ready = true;
		character.global_position = Vector2(position.x, position.y);
		get_node("/root/Game").add_child(character)
		character.float()
		

func explodeCar():
	explosion.emitting = true
	car_sprite.visible = false
	sprite_2d.visible = false
	Global.speed = 0
	Sounds.explosion.play()
	await get_tree().create_timer(2).timeout
	car_sprite.visible = true
	sprite_2d.visible = true
	Global.speed = 400
	
	

func itemHit():
	car_sprite.modulate = Color(2, 2, 2)
	await get_tree().create_timer(0.1).timeout
	car_sprite.modulate = Color(1,1,1)
	
	Sounds.coin.play()
	car_sprite.play("withVoters")

func defaultAnimation():
	car_sprite.play("default")

	
func hit():
	# Gjør bilen hvit
	Sounds.hurt.play()
	if !Global.is_invincible:
		
		car_sprite.modulate = Color(2, 2, 2)
		Global.is_invincible

		# Beveg litt bakover
		var knockback_distance := 50
		var knockback_speed := 500.0
		var target_position := position - Vector2(knockback_distance, 0)

		# Bruk tween for smooth bevegelse
		var tween := create_tween()
		tween.tween_property(self, "position", target_position, knockback_distance / knockback_speed)
		tween.tween_callback(Callable(self, "_on_hit_finished"))
		if Global.voters == 1:
			car_sprite.play("default")
		if Global.voters < 1:
			explodeCar()
	
func _on_hit_finished():
# Tilbakestill farge
	
	car_sprite.modulate = Color(1, 1, 1, 1)
	flash()
