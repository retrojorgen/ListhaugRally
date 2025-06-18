extends Node2D
var GameScene;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameScene = get_tree().current_scene;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func playAnimation():
	$AnimationPlayer.play("jump")
	
func _on_button_pressed() -> void:
	GameScene.restartGame()
	
