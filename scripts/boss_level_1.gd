extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SpeechPlayer.play("speech")
	pass # Replace with function body.
	

var invincible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@onready var bureaucrat = preload("res://scenes/obstacle.tscn")
@onready var voter = preload("res://scenes/character.tscn")
@onready var powerup = preload("res://scenes/powerup.tscn")
@onready var wall1 = preload("res://scenes/hole_wall_1.tscn")
@onready var wall2 = preload("res://scenes/hole_wall_2.tscn")
@onready var wall3 = preload("res://scenes/hole_wall_3.tscn")
@onready var upper_characters = preload("res://scenes/upperCharacters.tscn")
var lives = 40;
var index = 0;
var selectedSequence = 0;



func animateHit():
	$characterAll/character/BossAttack.modulate = Color(3,3,3)
	$characterAll/character/BossTalk.modulate = Color(3,3,3)
	
	await get_tree().create_timer(0.1).timeout
	$characterAll/character/BossAttack.modulate = Color(1,1,1)
	$characterAll/character/BossTalk.modulate = Color(1,1,1)





func update_attack_banner(current_value: int):
	var width = (current_value / 2) * 10
	#$EnergyBar.size.x = width
	var sprite = $CanvasLayer/attackbanner/Filled
	var rect = sprite.region_rect
	#print("width", width)
	rect.size.x = width
	sprite.region_rect = rect
		
func hit():
	if !invincible and lives > 0:
		animateHit()
		lives -= 1
		update_attack_banner(lives)
	if lives == 20:
		selectedSequence = 1
		$AnimationPlayer.play("float_middle")
	if lives == 10:
		selectedSequence = 2
		$AnimationPlayer.play("float_main")
	
	if lives == 0:
		$CollisionShape2D.disabled
		$SpeechPlayer.play("explode")
		
		selectedSequence = 3
	
func init():
	#GameScene = get_tree().current_scene;
	print("starting animation")
	start_sequence()
	#await get_tree().create_timer(400.0).timeout
#	run_sequence(post_60_seconds_sequence)
	invincible = false
		
func start_sequence():
	var current_sequence = sequence
	if selectedSequence == 1:
		current_sequence = sequence_middle
	if selectedSequence == 2:
		current_sequence = sequence_main
	if selectedSequence != 3:
			
		if index >= current_sequence.size():
			index = round(current_sequence.size() / 2)
		var step = current_sequence[index]	
		if Global.speed > 0:
			step.action.call() # kaller spawn_hole(), spawn_car() osv.
			await get_tree().create_timer(step.delay).timeout
			index += 1
			start_sequence()
	#await get_tree().create_timer(0.2).timeout
	
		#if Global.speed > 0:
			
func spawner(y, scene):
	$SpeechPlayer.play("magic")
	print("spawning")
	var x = 0
	var item = scene.instantiate()
	item.scale = Vector2(1.0, 1.0)
	item.global_position = Vector2(x,y)
	add_child(item)




var sequence = [
	{ "delay": 0.5, "action": func(): spawner(-25, voter) },
	{ "delay": 1.5, "action": func(): spawner(-25, wall1) },
	{ "delay": 1.5, "action": func(): spawner(-25, wall1) },
	{ "delay": 0.5, "action": func(): spawner(0, voter) },
	{ "delay": 2.0, "action": func(): spawner(-25, wall1) },
	{ "delay": 2.0, "action": func(): spawner(-25, wall1) },
	{ "delay": 1.0, "action": func(): spawner(-25, wall1) },
	{ "delay": 0.5, "action": func(): spawner(0, voter) },
	{ "delay": 0.5, "action": func(): spawner(40, voter) },
	{ "delay": 2.0, "action": func(): spawner(20, wall2) },
	{ "delay": 2.0, "action": func(): spawner(20, wall3) },
	{ "delay": 2.0, "action": func(): spawner(20, wall2) },
	{ "delay": 1.5, "action": func(): spawner(20, wall3) },
	{ "delay": 0.5, "action": func(): spawner(0, voter) },
	{ "delay": 2.0, "action": func(): spawner(20, wall2) },
	{ "delay": 2.0, "action": func(): spawner(20, wall3) },
]

var sequence_middle = [
	{ "delay": 0.5, "action": func(): spawner(-25, voter) },
	{ "delay": 1.0, "action": func(): spawner(-25, wall1) },
	{ "delay": 1.0, "action": func(): spawner(-25, wall1) },
	{ "delay": 1.0, "action": func(): spawner(-25, wall1) },
	{ "delay": 0.5, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(-25, wall1) },
	{ "delay": 1.0, "action": func(): spawner(-25, wall1) },
	{ "delay": 1.0, "action": func(): spawner(-25, wall1) },
	{ "delay": 0.5, "action": func(): spawner(0, voter) },
	{ "delay": 0.5, "action": func(): spawner(40, voter) },
	{ "delay": 1.0, "action": func(): spawner(20, wall2) },
	{ "delay": 1.0, "action": func(): spawner(20, wall3) },
	{ "delay": 0.5, "action": func(): spawner(-25, wall1) },
	{ "delay": 1.0, "action": func(): spawner(20, wall2) },
	{ "delay": 1.5, "action": func(): spawner(20, wall3) },
	{ "delay": 0.5, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(20, wall2) },
	{ "delay": 1.0, "action": func(): spawner(20, wall3) },
]

var sequence_main = [
	{ "delay": 0.5, "action": func(): spawner(-25, voter) },
	{ "delay": 1.0, "action": func(): spawner(-25, wall1) },
	{ "delay": 1.0, "action": func(): spawner(-25, wall1) },
	{ "delay": 0.0, "action": func(): spawner(0, bureaucrat) },
	{ "delay": 0.0, "action": func(): spawner(10, bureaucrat) },
	{ "delay": 0.0, "action": func(): spawner(20, bureaucrat) },
	{ "delay": 1.0, "action": func(): spawner(-25, wall1) },
	{ "delay": 0.5, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(-25, wall1) },
	{ "delay": 1.0, "action": func(): spawner(-25, wall1) },
	{ "delay": 0.0, "action": func(): spawner(20, bureaucrat) },
	{ "delay": 0.0, "action": func(): spawner(30, bureaucrat) },
	{ "delay": 0.0, "action": func(): spawner(40, bureaucrat) },
	{ "delay": 1.0, "action": func(): spawner(-25, wall1) },
	
	{ "delay": 0.5, "action": func(): spawner(0, voter) },
	{ "delay": 0.5, "action": func(): spawner(40, voter) },
	{ "delay": 1.0, "action": func(): spawner(20, wall2) },
	{ "delay": 1.0, "action": func(): spawner(20, wall3) },
	{ "delay": 0.0, "action": func(): spawner(20, bureaucrat) },
	{ "delay": 0.0, "action": func(): spawner(30, bureaucrat) },
	{ "delay": 0.0, "action": func(): spawner(40, bureaucrat) },
	{ "delay": 0.5, "action": func(): spawner(-25, wall1) },
	{ "delay": 1.0, "action": func(): spawner(20, wall2) },
	{ "delay": 1.5, "action": func(): spawner(20, wall3) },
	{ "delay": 0.5, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(20, wall2) },
	{ "delay": 1.0, "action": func(): spawner(20, wall3) },
]


func _on_area_entered(area: Area2D) -> void:
	if area.name.contains("waffle"):
		hit()
		area.queue_free()
