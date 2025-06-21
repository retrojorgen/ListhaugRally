extends Node2D
@onready var jump: AudioStreamPlayer = $jump
@onready var explosion: AudioStreamPlayer = $explosion
@onready var powerup: AudioStreamPlayer = $powerup
@onready var hurt: AudioStreamPlayer = $hurt
@onready var coin: AudioStreamPlayer = $coin
@onready var listhaug_bil: AudioStreamPlayer = $listhaugBil
@onready var listhaug_stemmer: AudioStreamPlayer = $listhaugStemmer
@onready var yehaa_2: AudioStreamPlayer = $yehaa2
@onready var yehaa_3: AudioStreamPlayer = $yehaa3
@onready var yehaa_4: AudioStreamPlayer = $yehaa4
@onready var yehaa_1: AudioStreamPlayer = $yehaa1



func getRandomYahooSound():
	var sounds = [yehaa_1, yehaa_2, yehaa_3, yehaa_4]
	return sounds[randi() % sounds.size()]
