extends Node2D
# The main purpose of this file is to be the only place that can update the global game data
# mostly the player should communicate with the functions here

@onready var parallax_background: ParallaxBackground = $ParallaxBackground
@onready var player: CharacterBody2D = $Player
@onready var background_music: AudioStreamPlayer = $BackgroundMusic
@onready var scene_items_handler: Node2D = $SceneItemsHandler
#@onready var spawn_timer: Timer = $SpawnTimer
#@onready var screen_size = get_viewport_rect().size
#@onready var character_timer: Timer = $CharacterTimer
#@onready var locale_timer: Timer = $LocaleTimer
#@onready var powerup_timer: Timer = $PowerupTimer
#var background_speed := 200
#var voters := 0;
#var collectedVoters = 0;

signal values

func increaseWaffles():
	Global.waffles += 1


func decreaseWaffles():
	Global.waffles -= 1
	
func removeWaffles():
	Global.waffles = 0	

func setInvincible():
	Global.is_invincible = true
	

func removeInvincible():
	Global.is_invincible = false
	
func toggleJumping():
	Global.is_jumping = !Global.is_jumping


# if an enemy causes the player to lose a voter
func decreaseVoters():
	if Global.voters == 0:
		return
	else:
		if Global.voters > 0:
			Global.voters -= 1
	emit_signal("values")

# if the user picks up a voter		
func increaseVoters():
	if Global.voters < 10:
		Global.voters += 1
	emit_signal("values")

# if for instance an enemy only causes the player to lose all voters (currently only toll booth)
func loseVoters():
	Global.voters = 0
	emit_signal("values")

func decreaseLife():
	#make sure the voters are set to 0. This should already be a fact most of the times.
	Global.voters = 0
	Global.lives -= 1
	removeWaffles()
	emit_signal("values")
	if Global.lives == 0:
		gameOver()


# when the player has no lives left the game should stop, and we should show a game over screen
func gameOver():
	#stop the game
	print("game over")
	emit_signal("values")

# Stop the game by pausing the speed
func stopGame():
	Global.previousSpeed = Global.speed
	Global.speed = 0
	emit_signal("values")

# Start the game by setting the speed back to what it was before it was paused		
func startGame():
	scene_items_handler.start_sequence()
	Global.speed = Global.previousSpeed	
	emit_signal("values")

# Moves the voters into the collectedVoters counter
func collectVoters():
	Global.collectedVoters += Global.voters
	emit_signal("values")
		
func _ready():
	
	background_music.play()
	scene_items_handler.init()

#moves the parallax background scroller	
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
	

#func _on_obstacle_collision():
#	if !Global.is_invincible:
#		if Global.voters > 0:
#			Global.voters -= 1
#		emit_signal("values")
#		
#	
#func _on_powerup_collision():
#	player.flash()
