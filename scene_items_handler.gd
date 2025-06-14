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
@onready var wall4 = preload("res://scenes/hole_wall_4.tscn")




#var post_60_seconds_sequence = [
#	{ "delay": 1.0, "action": func(): spawner(0, voter) },
#	{ "delay": 1.5, "action": func(): spawner(0, voter) },
#	{ "delay": 2.0, "action": func(): spawner(0, voter) },
#]

#Vector2(Global.screen_size.x + 100, randomYPosOnTrack());


# the point of this is to 

var index = 0;
var selectedSequence = 0;

func _ready():
	pass
	#init()
	
func init():
	#GameScene = get_tree().current_scene;
	print("is this running?")
	start_sequence()
	#await get_tree().create_timer(400.0).timeout
#	run_sequence(post_60_seconds_sequence)
	
func start_sequence():
	var current_sequence = sequence
	if Global.collectedVoters >= 25 and Global.collectedVoters < 35:
		current_sequence = sequence_middle
	if Global.collectedVoters >= 35:
		current_sequence = sequence_main
	
	#if selectedSequence == 1:
		
	#if selectedSequence == 2:
		#current_sequence = sequence_main
	if Global.collectedVoters < Global.maxCollectedVoters:
			
		if index >= current_sequence.size():
			index = 1
		var step = current_sequence[index]	
		if Global.speed > 0:
			step.action.call() # kaller spawn_hole(), spawn_car() osv.
			await get_tree().create_timer(step.delay).timeout
			index += 1
			
			start_sequence()
		
#generate random position of y between top and bottom part of track
func randomYPosOnTrack():
		return randi_range(Global.TOP_OF_TRACK, Global.BOTTOM_OF_TRACK)

func restart():
	print("Restarting game scene")

	# Fjern alle spawnede objekter
	for child in get_children():
		if child is CharacterBody2D or child is Node2D:
			# Du kan være mer spesifikk hvis du vil unngå å fjerne musikk eller UI
			if child.scene_file_path != "":
				remove_child(child)
				child.queue_free()

	# Tilbakestill index
	index = 0
	init()
	
func spawner(y, scene):
	var x = Global.screen_size.x + 100
	var item = scene.instantiate()
	item.global_position = Vector2(x,y)
	add_child(item)
	
	

var sequence = [
	{ "delay": 1.0, "action": func(): spawner(Global.TOP_OF_LEVEL, sign_molde) },
	{ "delay": 1.0, "action": func(): spawner(0, bureaucrat) },
	{ "delay": 1.0, "action": func(): spawner(50, bureaucrat) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(-200, locale) },
	{ "delay": 1.0, "action": func(): spawner(Global.TOP_OF_LEVEL, upper_characters) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(Global.TOP_OF_LEVEL, upper_characters) },
	{ "delay": 1.0, "action": func(): spawner(40, toll_station) },
	{ "delay": 0.0, "action": func(): spawner(0, hole) },
	{ "delay": 0.0, "action": func(): spawner(-200, locale) },
	{ "delay": 1.0, "action": func(): spawner(20, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(Global.TOP_OF_LEVEL, upper_characters) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(10, hole) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(Global.TOP_OF_LEVEL, upper_characters) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	
	{ "delay": 0.0, "action": func(): spawner(-200, locale) },
]

var sequence_middle = [
	{ "delay": 1.0, "action": func(): spawner(Global.TOP_OF_LEVEL, sign_molde) },
	{ "delay": 0.2, "action": func(): spawner(0, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(100, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(150, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(50, bureaucrat) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(40, toll_station) },
	{ "delay": 1.0, "action": func(): spawner(Global.TOP_OF_LEVEL, upper_characters) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.2, "action": func(): spawner(0, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(50, bureaucrat) },
	{ "delay": 0.0, "action": func(): spawner(0, wall4) },
	{ "delay": 0.0, "action": func(): spawner(-200, locale) },
	{ "delay": 0.2, "action": func(): spawner(20, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(60, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(80, bureaucrat) },
	{ "delay": 1.0, "action": func(): spawner(100, bureaucrat) },
	{ "delay": 1.0, "action": func(): spawner(40, voter) },
	{ "delay": 0.2, "action": func(): spawner(120, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(160, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(180, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(200, bureaucrat) },
	{ "delay": 1.0, "action": func(): spawner(Global.TOP_OF_LEVEL, upper_characters) },
	{ "delay": 1.0, "action": func(): spawner(40, toll_station) },
	{ "delay": 0.0, "action": func(): spawner(40, wall4) },
	{ "delay": 0.2, "action": func(): spawner(20, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(60, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(80, bureaucrat) },
	{ "delay": 1.0, "action": func(): spawner(100, bureaucrat) },
	{ "delay": 0.0, "action": func(): spawner(20, bureaucrat) },
	{ "delay": 0.4, "action": func(): spawner(80, bureaucrat) },
	{ "delay": 0.6, "action": func(): spawner(120, bureaucrat) },
	{ "delay": 1.0, "action": func(): spawner(160, bureaucrat) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(-200, locale) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(Global.TOP_OF_LEVEL, upper_characters) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(40, wall4) },
	{ "delay": 1.0, "action": func(): spawner(40, toll_station) },
	{ "delay": 0.0, "action": func(): spawner(40, hole) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(Global.TOP_OF_LEVEL, upper_characters) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(-200, locale) },
]

var sequence_main = [
	{ "delay": 1.0, "action": func(): spawner(Global.TOP_OF_LEVEL, sign_molde) },
	{ "delay": 0.2, "action": func(): spawner(0, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(100, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(150, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(50, bureaucrat) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(40, toll_station) },
	{ "delay": 1.0, "action": func(): spawner(Global.TOP_OF_LEVEL, upper_characters) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.2, "action": func(): spawner(0, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(50, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(100, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(150, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(80, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(50, bureaucrat) },
	{ "delay": 0.0, "action": func(): spawner(-200, locale) },
	{ "delay": 0.0, "action": func(): spawner(0, wall4) },
	{ "delay": 0.5, "action": func(): spawner(100, wall4) },
	{ "delay": 0.0, "action": func(): spawner(0, wall4) },
	{ "delay": 0.5, "action": func(): spawner(100, wall4) },
	{ "delay": 0.2, "action": func(): spawner(20, electric_car) },
	{ "delay": 0.2, "action": func(): spawner(60, electric_car) },
	{ "delay": 0.2, "action": func(): spawner(80, electric_car) },
	{ "delay": 1.0, "action": func(): spawner(100, electric_car) },
	{ "delay": 1.0, "action": func(): spawner(40, voter) },
	{ "delay": 0.2, "action": func(): spawner(120, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(160, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(180, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(200, bureaucrat) },
	{ "delay": 1.0, "action": func(): spawner(Global.TOP_OF_LEVEL, upper_characters) },
	{ "delay": 1.0, "action": func(): spawner(40, toll_station) },
	{ "delay": 0.0, "action": func(): spawner(0, hole) },
	{ "delay": 0.2, "action": func(): spawner(20, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(60, bureaucrat) },
	{ "delay": 0.2, "action": func(): spawner(80, bureaucrat) },
	{ "delay": 1.0, "action": func(): spawner(100, electric_car) },
	{ "delay": 1.0, "action": func(): spawner(100, bureaucrat) },
	{ "delay": 0.0, "action": func(): spawner(20, bureaucrat) },
	{ "delay": 0.0, "action": func(): spawner(80, bureaucrat) },
	{ "delay": 0.0, "action": func(): spawner(120, bureaucrat) },
	{ "delay": 1.0, "action": func(): spawner(160, bureaucrat) },
	{ "delay": 1.0, "action": func(): spawner(100, electric_car) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(Global.TOP_OF_LEVEL, upper_characters) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(0, hole) },
	{ "delay": 1.0, "action": func(): spawner(40, toll_station) },
	{ "delay": 0.0, "action": func(): spawner(40, hole) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(100, electric_car) },
	{ "delay": 1.0, "action": func(): spawner(200, electric_car) },
	{ "delay": 1.0, "action": func(): spawner(Global.TOP_OF_LEVEL, upper_characters) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 1.0, "action": func(): spawner(0, voter) },
	{ "delay": 0.0, "action": func(): spawner(-200, locale) },
]
