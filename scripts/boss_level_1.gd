extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label/SpeechPlayer.play("speech")
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@onready var bureaucrat = preload("res://scenes/obstacle.tscn")
@onready var voter = preload("res://scenes/character.tscn")
@onready var powerup = preload("res://scenes/powerup.tscn")
var lives = 40;
var index = 0;



func animateHit():
	$BossRegular.modulate = Color(3, 3, 3)
	await get_tree().create_timer(0.1).timeout
	$BossRegular.modulate = Color(1, 1, 1)
	
func hit():
	animateHit()
	lives -= 1
	



	
func init():
	#GameScene = get_tree().current_scene;
	start_sequence()
	#await get_tree().create_timer(400.0).timeout
#	run_sequence(post_60_seconds_sequence)
	
func start_sequence():
	if index >= sequence.size():
		index = round(sequence.size() / 2)
	var step = sequence[index]	
	step.action.call() # kaller spawn_hole(), spawn_car() osv.
	await get_tree().create_timer(step.delay).timeout
	if Global.speed > 0:
		index += 1
		start_sequence()
			
func spawner(y, scene):
	var x = Global.screen_size.x + 100
	var item = scene.instantiate()
	item.global_position = Vector2(x,y)
	add_child(item)






var sequence = [
	{ "delay": 1.0, "action": func(): spawner(0, powerup) },
	{ "delay": 1.0, "action": func(): spawner(0, powerup) },
]


func _on_area_entered(area: Area2D) -> void:
	if area.name.contains("waffle"):
		hit()
		area.queue_free()
