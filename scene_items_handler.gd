extends Node2D
#var GameScene;

@onready var bureaucrat = preload("res://scenes/obstacle.tscn")
@onready var voter = preload("res://scenes/character.tscn")
@onready var powerup = preload("res://scenes/powerup.tscn")
@onready var hole = preload("res://scenes/hole.tscn")
@onready var toll_station = preload("res://scenes/toll_station.tscn")
@onready var locale = preload("res://scenes/lokale.tscn")
@onready var electric_car = preload("res://scenes/electric_car.tscn")




var post_60_seconds_sequence = [
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.5, "action": func(): spawner(0, voter) },
	{ "delay": 2.0, "action": func(): spawner(0, voter) },
]

#Vector2(Global.screen_size.x + 100, randomYPosOnTrack());


# the point of this is to 



func init():
	#GameScene = get_tree().current_scene;
	run_sequence(initial_sequence)
	await get_tree().create_timer(60.0).timeout
	run_sequence(post_60_seconds_sequence)
	
func run_sequence(sequence: Array, index := 0):
	if index >= sequence.size():
		print("no more items in sequence")
		return
	var step = sequence[index]
	step.action.call() # kaller spawn_hole(), spawn_car() osv.
	await get_tree().create_timer(step.delay).timeout
	run_sequence(sequence, index + 1)
		
#generate random position of y between top and bottom part of track
func randomYPosOnTrack():
		return randi_range(Global.TOP_OF_TRACK, Global.BOTTOM_OF_TRACK)
	
func spawner(y, scene):
	var x = Global.screen_size.x + 100
	if y == 0:
		y = randomYPosOnTrack()
	var item = scene.instantiate()
	item.global_position = Vector2(x,y)
	add_child(item)






var initial_sequence = [
	
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(0, hole) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(0, hole) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(-200, locale) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(0, hole) },
	{ "delay": 0.0, "action": func(): spawner(0, hole) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(0, hole) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(0, hole) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(-200, locale) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(0, hole) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(0, hole) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(-200, locale) },
]
