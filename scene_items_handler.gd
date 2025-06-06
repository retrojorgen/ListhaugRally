extends Node2D
var GameScene;
@onready var spawn_timer: Timer = $SpawnTimer
@onready var character_timer: Timer = $CharacterTimer
@onready var locale_timer: Timer = $LocaleTimer
@onready var powerup_timer: Timer = $PowerupTimer




func init():
	spawn_timer.timeout.connect(spawn_obstacle)
	character_timer.timeout.connect(spawn_character)
	locale_timer.timeout.connect(spawn_locale)
	powerup_timer.timeout.connect(spawn_powerup)
	GameScene = get_tree().current_scene;
#generate random position of y between top and bottom part of track
func randomYPosOnTrack():
		return randi_range(Global.TOP_OF_TRACK, Global.BOTTOM_OF_TRACK)
		

func spawn_character():
	#print("character")
	var character = preload("res://scenes/character.tscn").instantiate()
	
	character.global_position = Vector2(Global.screen_size.x + 60, randomYPosOnTrack());
	character.character.connect(GameScene._on_character_collected)
	add_child(character)
	
	
	
func spawn_powerup():
	#print("character")
	var powerup = preload("res://scenes/powerup.tscn").instantiate()
	
	powerup.global_position = Vector2(Global.screen_size.x + 60, randomYPosOnTrack());
	powerup.powerup.connect(GameScene._on_powerup_collision)
	add_child(powerup)

func spawn_locale():
	
	var locale = preload("res://scenes/lokale.tscn").instantiate()
	locale.global_position = Vector2(Global.screen_size.x + 40, Global.TOP_OF_TRACK -40);
	locale.lokale.connect(GameScene._on_locale_collision)
	add_child(locale)
	
func spawn_obstacle():
	#print("spawning obstacle")
	var obstacle = preload("res://scenes/obstacle.tscn").instantiate()
	
	
	obstacle.global_position = Vector2(Global.screen_size.x + 100, randomYPosOnTrack());
	obstacle.obstacle.connect(GameScene._on_obstacle_collision)
	#obstacle.global_position = Vector2(get_viewport_rect().size.x + 100, randf_range(200, 400))
	add_child(obstacle)
	#print("Obstacle added to:", obstacle.get_parent())
