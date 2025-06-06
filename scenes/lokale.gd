extends Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D



signal lokale

@export var speed :=200.0



func _process(delta):
	global_position.x -= Global.speed * delta


func itemHit():
	sprite_2d.modulate = Color(2, 2, 2)
	await get_tree().create_timer(0.1).timeout
	sprite_2d.modulate = Color(1,1,1)

func showCharacters(characters):
	if characters > 10:
		characters = 10
	for i in range(1, characters+1):  # Adjust upper limit if you have more characters
		var node_name = "character%d" % i
		var character = $characters.get_node(node_name)
		character.visible = true
	
		
func _on_body_entered(body: Node2D) -> void:
	#player wants to deliver voters
	if body.name == "Player":
		itemHit()
		body.defaultAnimation()
		#print(Global.voters)
		Sounds.listhaug_stemmer.play()
		showCharacters(Global.voters)
		emit_signal("lokale")
		


func _on_area_entered(area: Area2D) -> void:
	if area.name == "StopItems":
		queue_free()
