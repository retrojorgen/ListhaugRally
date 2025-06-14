extends CharacterBody2D
@onready var car_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
const WAFFLE = preload("res://scenes/waffle.tscn")
const VOTER = preload("res://scenes/character.tscn")
@onready var explosion: CPUParticles2D = $explosion

@onready var sprite_2d: Sprite2D = $Sprite2D
var GameScene;


const SPEED = 400.0
const JUMP_VELOCITY = -600.0
var gravity := 400.0
var jump_origin_y := 0.0
var jump_height := 60.0
var jump_speed := 300.0
var going_up := true
@onready var jumpSound: AudioStreamPlayer = $Sounds/jump
@onready var explosionSound: AudioStreamPlayer = $Sounds/explosion
@onready var powerupSound: AudioStreamPlayer = $Sounds/powerup
@onready var hurtSound: AudioStreamPlayer = $Sounds/hurt
@onready var coinSound: AudioStreamPlayer = $Sounds/coin



func _ready():
	Sounds.listhaug_bil.play()
	GameScene = get_tree().current_scene;

# emits a waffle bullet from the player
func spawn_waffle():
	#print("spawning obstacle")
	var waffleInstance = WAFFLE.instantiate()
	
	waffleInstance.global_position = Vector2(position.x, position.y);
	get_node("/root/Game").add_child(waffleInstance)
	Sounds.powerup.play()
	


func powerUp():
	GameScene.increaseWaffles()

#makes the player invincible for five seconds
func flash():
	Global.is_invincible = true
	print("invincible")
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
	await get_tree().create_timer(4.0).timeout

	blink_timer.stop()
	blink_timer.queue_free()
	car_sprite.modulate.a = 1.0
	sprite_2d.modulate.a = 1.0
	print("not invicible")
	Global.is_invincible = false
	
# the main loop of the player
# controls are handled here		
func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 2
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
	if Input.is_action_just_pressed("ui_accept") and not Global.is_jumping:
		Sounds.jump.play()
		GameScene.toggleJumping()
		#collision_shape_2d.disabled = true 
		going_up = true
		jump_origin_y = car_sprite.position.y

	# Flytt kun sprite opp og ned
	if Global.is_jumping:
		if going_up:
			car_sprite.position.y -= jump_speed * delta
			if car_sprite.position.y <= jump_origin_y - jump_height:
				going_up = false
				
		else:
			car_sprite.position.y += jump_speed * delta
			if car_sprite.position.y >= jump_origin_y:
				car_sprite.position.y = jump_origin_y
				GameScene.toggleJumping()
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
		

# if a player hits an enemy that makes it lose all voters
func loseAllVoters():
	loseVoters(Global.voters)
	GameScene.loseVoters()
	car_sprite.play("default")
	$grayParticles.visible = true
	$AppleParticles.visible = false

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
		await get_tree().create_timer(0.1).timeout

func showCar():
	car_sprite.visible = true
	sprite_2d.visible = true
	defaultAnimation()
	
func instantKill():
	flash()
	explodeCar()	
	GameScene.decreaseLife()
	
func explodeCar():
	explosion.emitting = true
	car_sprite.visible = false
	sprite_2d.visible = false
	$grayParticles.visible = false
	$AppleParticles.visible = false
	GameScene.stopGame()
	Sounds.explosion.play()
	#We have more tries left
	if Global.lives > 1:
		await get_tree().create_timer(2).timeout
		car_sprite.visible = true
		sprite_2d.visible = true
		GameScene.startGame()

func showCarAfterExplosion():
	#GameScene.stopGame()
	#Sounds.explosion.play()
	#await get_tree().create_timer(2).timeout
	car_sprite.visible = true
	sprite_2d.visible = true
	#GameScene.startGame()	


func defaultAnimation():
	car_sprite.play("default")
	$grayParticles.restart()
	$grayParticles.visible = true
	$AppleParticles.visible = false

func animationWithVoters():
	car_sprite.play("withVoters")
	$grayParticles.visible = false
	$AppleParticles.restart()
	$AppleParticles.visible = true
	
		
# when the player collides with an item
func _itemHit():
	car_sprite.modulate = Color(2, 2, 2)
	await get_tree().create_timer(0.1).timeout
	car_sprite.modulate = Color(1,1,1)


func voterCollision():
	_itemHit()
	Sounds.coin.play()
	
	#car_sprite.play("withVoters")
	GameScene.increaseVoters()
	if Global.voters == 1:
		animationWithVoters()

# used if a player collides with an object that only decreases voters
func noHitObstacleCollision():
	
	GameScene.loseVoters()

func localeCollision():
	_itemHit()
	defaultAnimation()
	GameScene.collectVoters()



func obstacleCollision():
	Sounds.hurt.play()
	
	if Global.voters >= 1:
		loseAllVoters()
	if !Global.is_invincible:
		hit()
	
# used to mark when something happens to the player
func brightenPlayer():
	car_sprite.modulate = Color(2, 2, 2)
	
# reset brightness to normal
func resetBrightnessPlayer():
	car_sprite.modulate = Color(1, 1, 1, 1)
		
# when the player collides with an obstacle	
func hit():
	flash()
	brightenPlayer()
		# Beveg litt bakover
	#var knockback_distance := 50
	#var knockback_speed := 500.0
	#var target_position := position - Vector2(knockback_distance, 0)		# Bruk tween for smooth bevegelse
	#var tween := create_tween()
	#tween.tween_property(self, "position", target_position, knockback_distance / knockback_speed)
	#tween.tween_callback(Callable(self, "_on_hit_finished"))
	_on_hit_finished()
		
func _on_hit_finished():
	# Tilbakestill farge
	#car_sprite.modulate = Color(1, 1, 1, 1)
	resetBrightnessPlayer()
	
	if Global.voters < 1:
		explodeCar()
	else:
		GameScene.loseVoters()
		loseAllVoters()
		
	
	
