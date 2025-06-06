extends Node2D

@onready var parallax_background: ParallaxBackground = $ParallaxBackground
@onready var player: CharacterBody2D = $Player
@onready var spawn_timer: Timer = $SpawnTimer
@onready var screen_size = get_viewport_rect().size
@onready var character_timer: Timer = $CharacterTimer
@onready var locale_timer: Timer = $LocaleTimer
@onready var powerup_timer: Timer = $PowerupTimer
@onready var background_music: AudioStreamPlayer = $BackgroundMusic

@onready var scene_items_handler: Node2D = $SceneItemsHandler


var background_speed := 200
var voters := 0;
var collectedVoters = 0;



signal values


func _ready():
	
	background_music.play()
	scene_items_handler.init()
	
func _physics_process(delta):
	#print(Global.speed)
	parallax_background.scroll_base_offset.x -= Global.speed * delta

func _on_character_collected():
	Global.voters += 1
	
	emit_signal("values")	

func _on_locale_collision():
	Global.collectedVoters += Global.voters
	Global.voters = 0
	emit_signal("values")
	

func _on_obstacle_collision():
	if !Global.is_invincible:
		if Global.voters > 0:
			Global.voters -= 1
		emit_signal("values")
		
	
func _on_powerup_collision():
	player.flash()
