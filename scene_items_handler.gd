extends Node2D
#var GameScene;

@onready var bureaucrat = preload("res://scenes/obstacle.tscn")
@onready var voter = preload("res://scenes/character.tscn")
@onready var powerup = preload("res://scenes/powerup.tscn")
@onready var hole = preload("res://scenes/hole.tscn")
@onready var toll_station = preload("res://scenes/toll_station.tscn")
@onready var locale = preload("res://scenes/lokale.tscn")
@onready var electric_car = preload("res://scenes/electric_car.tscn")
@onready var sign_molde = preload("res://scenes/sign_molde.tscn")
@onready var upper_characters = preload("res://scenes/upperCharacters.tscn")




#var post_60_seconds_sequence = [
#	{ "delay": 1.0, "action": func(): spawner(0, voter) },
#	{ "delay": 1.5, "action": func(): spawner(0, voter) },
#	{ "delay": 2.0, "action": func(): spawner(0, voter) },
#]

#Vector2(Global.screen_size.x + 100, randomYPosOnTrack());


# the point of this is to 

var index = 0;

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
		
#generate random position of y between top and bottom part of track
func randomYPosOnTrack():
		return randi_range(Global.TOP_OF_TRACK, Global.BOTTOM_OF_TRACK)
	
func spawner(y, scene):
	var x = Global.screen_size.x + 100
	var item = scene.instantiate()
	item.global_position = Vector2(x,y)
	add_child(item)






var sequence = [
	{ "delay": 1.0, "action": func(): spawner(Global.TOP_OF_LEVEL, sign_molde) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(Global.TOP_OF_LEVEL, upper_characters) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(40, toll_station) },
	{ "delay": 0.0, "action": func(): spawner(0, hole) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(0, hole) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(-200, locale) },
]
