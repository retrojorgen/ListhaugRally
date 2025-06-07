extends Node2D
#var GameScene;

var bureaucrat = preload("res://scenes/obstacle.tscn")
var voter = preload("res://scenes/character.tscn")
var powerup = preload("res://scenes/powerup.tscn")
var hole = preload("res://scenes/powerup.tscn")
var toll_station = preload("res://scenes/toll_station.tscn")
var locale = preload("res://scenes/lokale.tscn")
var electric_car = preload("res://scenes/electric_car.tscn")


var initial_sequence = [
	{ "delay": 1.0, "action": () => spawner(0, voter) },
	{ "delay": 1.5, "action": () => spawn_obstacle() },
	{ "delay": 2.0, "action": () => spawn_powerup() }
]

var post_60_seconds_sequence = [
	{ "delay": 1.0, "action": () => spawn_hole() },
	{ "delay": 0.5, "action": () => spawn_hole() },
	{ "delay": 0.5, "action": () => spawn_hole() },
	{ "delay": 0.5, "action": () => spawn_hole() },
	{ "delay": 1.0, "action": () => spawn_electricCar() },
	{ "delay": 0.5, "action": () => spawn_electricCar() },
	{ "delay": 1.0, "action": () => spawn_hole() },
	{ "delay": 0.5, "action": () => spawn_hole() },
	{ "delay": 0.5, "action": () => spawn_hole() },
	{ "delay": 0.5, "action": () => spawn_hole() }
]

#Vector2(Global.screen_size.x + 100, randomYPosOnTrack());


# the point of this is to 



func init():
	GameScene = get_tree().current_scene;
#generate random position of y between top and bottom part of track
func randomYPosOnTrack():
		return randi_range(Global.TOP_OF_TRACK, Global.BOTTOM_OF_TRACK)
	
func spawner(y := 0, scene):
	var x = Global.screen_size.x + 100
	if y == 0:
		randomYPosOnTrack()
	var item = scene.instantiate()
	item.global_position = Vector2(x,y)
	add_child(item)
