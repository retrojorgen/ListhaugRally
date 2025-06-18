extends Node2D
@onready var anim_player: AnimationPlayer = $AnimationPlayer

const STEP_DURATION := 10.0

var speechPlayed = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$AnimationPlayer.play("speech")
	start_speech_timer()
	pass # Replace with function body.
	
func start_speech_timer():
	await get_tree().create_timer(60.0).timeout
	speechPlayed = true
	print("60 sekunder har gått — speechPlayed = true")    

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func jump_to_next_step():
	var current_time = anim_player.current_animation_position
	var anim_length = anim_player.current_animation_length

	# Finn neste steg
	var next_step = ceil(current_time / STEP_DURATION) * STEP_DURATION

	if next_step >= anim_length:
		next_step = anim_length
		speechPlayed = true
		print("Animasjonen er ferdig eller på siste steg.")
	else:
		anim_player.seek(next_step, true)
		if next_step == 60:
			speechPlayed = true
		print("Hopper til tid: ", next_step)


func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE and !speechPlayed:
		jump_to_next_step()
	else:	
		if event is InputEventKey and event.pressed and speechPlayed == true:
			print("laster neste scene")
			var new_scene = load("res://scenes/game.tscn") as PackedScene
			get_tree().change_scene_to_packed(new_scene)
