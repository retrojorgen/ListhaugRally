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
# should go up to ten
var sequenceIndex = 0;

func _ready():
	spawner(Global.TOP_OF_LEVEL, sign_molde)	
	pass
	#init()
	
func init():
	#GameScene = get_tree().current_scene;
	#print("is this running?")
	start_sequence(Global.lives)
	start_background(Global.lives)
	await get_tree().create_timer(2.0).timeout
	start_enemies(Global.lives)
	await get_tree().create_timer(4.0).timeout
	start_locale(Global.lives)


# Sending lives so that if lives are decreased the sequence stops.

func start_background(lives):
	var background = { "delay": 2.0, "action": func(): spawner(Global.TOP_OF_LEVEL- 40, upper_characters) }
	if Global.speed > 0:
			background.action.call() # kaller spawn_hole(), spawn_car() osv.
			await get_tree().create_timer(background.delay).timeout
			start_background(Global.lives)

func start_locale(lives):
	var background = { "delay": 10 + (sequenceIndex * 2), "action": func(): spawner(Global.TOP_OF_LEVEL, locale) }
	if Global.speed > 0 && Global.lives == lives && Global.collectedVoters < Global.maxCollectedVoters:
			background.action.call() # kaller spawn_hole(), spawn_car() osv.
			await get_tree().create_timer(background.delay).timeout
			start_locale(Global.lives)

func start_enemies(lives):
	#print(randomYPosOnLevel())
	var background = { "delay": 1.5 + sequenceIndex, "action": func(): spawner(randomYPosOnLevel(), bureaucrat) }
	if Global.speed > 0 && Global.lives == lives:
			background.action.call() # kaller spawn_hole(), spawn_car() osv.
			await get_tree().create_timer(background.delay).timeout
			start_enemies(Global.lives)
		
func start_sequence(lives):
	var current_sequence = sequences
	if Global.collectedVoters >= 10 && sequenceIndex < 1:
		sequenceIndex = 1
	
	if Global.collectedVoters >= 20 && sequenceIndex < 2:
		sequenceIndex = 2	
	
	if Global.collectedVoters >= 30 && sequenceIndex < 3:
		sequenceIndex = 3
		
	if Global.collectedVoters >= 40 && sequenceIndex < 4:
		sequenceIndex = 4	
	
	if Global.collectedVoters < Global.maxCollectedVoters:
		if index >= sequences[sequenceIndex].size():
			index = 0
		var step = sequences[sequenceIndex][index]
		#print(step, sequenceIndex, index)
		if Global.speed > 0 && Global.lives == lives:
			step.action.call() # kaller spawn_hole(), spawn_car() osv.
			if step.delay > 0:
				await get_tree().create_timer(step.delay).timeout
			index += 1
			
			start_sequence(Global.lives)


func randomYPosOnLevel():
		return randi_range(Global.TOP_OF_LEVEL, Global.BOTTOM_OF_LEVEL)	
#generate random position of y between top and bottom part of track
func randomYPosOnTrack():
		return randi_range(Global.TOP_OF_TRACK, Global.BOTTOM_OF_TRACK)

func restart():
	#print("Restarting game scene")

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
	
	

var sequences = [
	#first learning wave
	[
		{ "delay": 2, "action": func(): spawner(0, hole) },
		{ "delay": 2, "action": func(): spawner(100, hole) },
		{ "delay": 2, "action": func(): spawner(0, hole) },
		{ "delay": 2, "action": func(): spawner(100, hole) },
	],
	#second wave with toll station
	[
		{ "delay": 1.5, "action": func(): spawner(randomYPosOnTrack(), hole) },
		{ "delay": 1.5, "action": func(): spawner(randomYPosOnTrack(), hole) },
		{ "delay": 1.5, "action": func(): spawner(randomYPosOnTrack(), hole) },
		{ "delay": 1.5, "action": func(): spawner(randomYPosOnTrack(), hole) },
		{ "delay": 2, "action": func(): spawner(40, toll_station) },
		
	],
	[
	#third wave with more holes
	{ "delay": 1.5, "action": func(): spawner(0, wall4) },
	{ "delay": 1.5, "action": func(): spawner(200, wall4) },
	{ "delay": 1.5, "action": func(): spawner(0, wall4) },
	{ "delay": 1.5, "action": func(): spawner(200, wall4) },
	{ "delay": 1.5, "action": func(): spawner(0, wall4) },
	{ "delay": 2, "action": func(): spawner(200, wall4) },
	{ "delay": 2, "action": func(): spawner(40, toll_station) },
	{ "delay": 4, "action": func(): spawner(randomYPosOnTrack(), electric_car) },
	],
	#fourth wave with wall
	[
	{ "delay": 0.0, "action": func(): spawner(-120, hole) },
	{ "delay": 0.0, "action": func(): spawner(-60, hole) },
	{ "delay": 0.0, "action": func(): spawner(0, hole) },
	{ "delay": 0.0, "action": func(): spawner(60, hole) },
	{ "delay": 2.0, "action": func(): spawner(120, hole) },
	{ "delay": 0.5, "action": func(): spawner(randomYPosOnTrack(), electric_car) },	

	{ "delay": 1.5, "action": func(): spawner(0, wall4) },
	{ "delay": 1.5, "action": func(): spawner(200, wall4) },
	{ "delay": 2, "action": func(): spawner(40, toll_station) },
	{ "delay": 0.5, "action": func(): spawner(randomYPosOnTrack(), electric_car) },
	],
	#fifth wave with electric cars
	[
	{ "delay": 0.0, "action": func(): spawner(randomYPosOnTrack(), electric_car) },
	{ "delay": 0.5, "action": func(): spawner(randomYPosOnTrack(), electric_car) },	
	{ "delay": 0.5, "action": func(): spawner(randomYPosOnTrack(), electric_car) },	
	{ "delay": 0.5, "action": func(): spawner(randomYPosOnTrack(), electric_car) },	
	{ "delay": 0.5, "action": func(): spawner(randomYPosOnTrack(), electric_car) },	
	{ "delay": 0.0, "action": func(): spawner(-120, hole) },
	{ "delay": 0.0, "action": func(): spawner(-60, hole) },
	{ "delay": 0.0, "action": func(): spawner(0, hole) },
	{ "delay": 0.0, "action": func(): spawner(60, hole) },
	{ "delay": 0.0, "action": func(): spawner(120, hole) },
	]
]

#var sequence_middle = [
	#{ "delay": 0.2, "action": func(): spawner(0, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(100, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(150, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(50, bureaucrat) },
	#{ "delay": 1.0, "action": func(): spawner(40, toll_station) },
	#{ "delay": 0.2, "action": func(): spawner(0, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(50, bureaucrat) },
	#{ "delay": 0.0, "action": func(): spawner(0, wall4) },
	#{ "delay": 0.0, "action": func(): spawner(-200, locale) },
	#{ "delay": 0.2, "action": func(): spawner(20, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(60, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(80, bureaucrat) },
	#{ "delay": 1.0, "action": func(): spawner(100, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(120, bureaucrat) },
	#{ "delay": 1.0, "action": func(): spawner(200, electric_car) },
	#{ "delay": 0.2, "action": func(): spawner(160, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(180, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(200, bureaucrat) },
	#{ "delay": 1.0, "action": func(): spawner(200, electric_car) },
	#{ "delay": 1.0, "action": func(): spawner(40, toll_station) },
	#{ "delay": 0.0, "action": func(): spawner(40, wall4) },
	#{ "delay": 0.2, "action": func(): spawner(20, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(60, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(80, bureaucrat) },
	#{ "delay": 1.0, "action": func(): spawner(100, bureaucrat) },
	#{ "delay": 1.0, "action": func(): spawner(200, electric_car) },
	#{ "delay": 0.0, "action": func(): spawner(20, bureaucrat) },
	#{ "delay": 0.4, "action": func(): spawner(80, bureaucrat) },
	#{ "delay": 0.6, "action": func(): spawner(120, bureaucrat) },
	#{ "delay": 1.0, "action": func(): spawner(160, bureaucrat) },
	#{ "delay": 1.0, "action": func(): spawner(200, electric_car) },
	#{ "delay": 0.0, "action": func(): spawner(-200, locale) },
	#{ "delay": 0.0, "action": func(): spawner(40, wall4) },
	#{ "delay": 1.0, "action": func(): spawner(40, toll_station) },
	#{ "delay": 0.0, "action": func(): spawner(40, hole) },
	#{ "delay": 0.0, "action": func(): spawner(-200, locale) },
#]
#
#var sequence_main = [
	#
	#{ "delay": 0.2, "action": func(): spawner(0, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(100, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(150, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(50, bureaucrat) },
	#
	#{ "delay": 1.0, "action": func(): spawner(40, toll_station) },
	#
	#
	#{ "delay": 0.2, "action": func(): spawner(0, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(50, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(100, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(150, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(80, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(50, bureaucrat) },
	#{ "delay": 0.0, "action": func(): spawner(-200, locale) },
	#
	#{ "delay": 0.2, "action": func(): spawner(20, electric_car) },
	#{ "delay": 0.2, "action": func(): spawner(60, electric_car) },
	#{ "delay": 0.2, "action": func(): spawner(80, electric_car) },
	#{ "delay": 1.0, "action": func(): spawner(100, electric_car) },
	#{ "delay": 0.0, "action": func(): spawner(100, wall4) },
	#{ "delay": 2, "action": func(): spawner(200, wall4) },
	#{ "delay": 2, "action": func(): spawner(100, wall4) },
	#{ "delay": 2, "action": func(): spawner(200, wall4) },
	#
	#{ "delay": 0.2, "action": func(): spawner(120, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(160, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(180, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(200, bureaucrat) },
	#
	#{ "delay": 1.0, "action": func(): spawner(40, toll_station) },
	#{ "delay": 0.0, "action": func(): spawner(0, hole) },
	#{ "delay": 0.2, "action": func(): spawner(20, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(60, bureaucrat) },
	#{ "delay": 0.2, "action": func(): spawner(80, bureaucrat) },
	#{ "delay": 1.0, "action": func(): spawner(100, electric_car) },
	#{ "delay": 1.0, "action": func(): spawner(100, bureaucrat) },
	#{ "delay": 0.0, "action": func(): spawner(20, bureaucrat) },
	#{ "delay": 0.0, "action": func(): spawner(80, bureaucrat) },
	#{ "delay": 0.0, "action": func(): spawner(120, bureaucrat) },
	#{ "delay": 1.0, "action": func(): spawner(160, bureaucrat) },
	#{ "delay": 1.0, "action": func(): spawner(100, electric_car) },
#
	#{ "delay": 0.0, "action": func(): spawner(0, hole) },
	#{ "delay": 1.0, "action": func(): spawner(40, toll_station) },
	#{ "delay": 0.0, "action": func(): spawner(40, hole) },
	#
	#{ "delay": 1.0, "action": func(): spawner(100, electric_car) },
	#{ "delay": 1.0, "action": func(): spawner(200, electric_car) },
	#
	#{ "delay": 0.0, "action": func(): spawner(-200, locale) },
#]
