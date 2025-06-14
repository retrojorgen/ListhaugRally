extends CanvasLayer
@onready var main_character_1: Sprite2D = $Lives/MainCharacter1
@onready var main_character_2: Sprite2D = $Lives/MainCharacter2
@onready var main_character_3: Sprite2D = $Lives/MainCharacter3
@onready var main_character_4: Sprite2D = $Lives/MainCharacter4
@onready var filledbar: Sprite2D = $Voters/filledbar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		get_tree().get_root().get_node("Game").values.connect(updateValues)
		updateValues()


var max_VoterValue := 10
var max_VotersWidth := 20



func update_voters_bar(current_value: int):
	var width = clamp(current_value, 0, max_VoterValue) * (max_VotersWidth / max_VoterValue)
	#$EnergyBar.size.x = width
	var sprite = $Voters/filledbar
	var rect = sprite.region_rect
	#print("width", width)
	rect.size.x = width
	sprite.region_rect = rect

func update_collected_voters_bar(current_value: int):
	var sprite = $CollectedVoters/filledbar
	var rect = sprite.region_rect
	rect.size.x = Global.collectedVoters * 2
	sprite.region_rect = rect
	#$CollectedVoters/filledbar.region.size.x = Global.collectedVoters
	
func updateValues():
	print("updating values ",Global.lives)
	if Global.lives == 1:
		main_character_1.visible = true
		main_character_2.visible = false
		main_character_3.visible = false
		main_character_4.visible = false
	if Global.lives == 2:
		main_character_1.visible = true
		main_character_2.visible = true
		main_character_3.visible = false
		main_character_4.visible = false
	if Global.lives == 3:
		main_character_1.visible = true
		main_character_2.visible = true
		main_character_3.visible = true
		main_character_4.visible = false
	if Global.lives == 4:
		main_character_1.visible = true
		main_character_2.visible = true
		main_character_3.visible = true
		main_character_4.visible = true
	
	# Sett dette på en Control-node eller TextureRect for å justere bredden
	update_voters_bar(Global.voters)
	update_collected_voters_bar(Global.collectedVoters)
	if Global.voters == 10:
		$Voters/glowing.visible = true
	else:
		$Voters/glowing.visible = false

	#main_character_label.text = str(Global.lives)
	#picker_character_label.text = str(Global.voters)
	#booth_character_label.text = str(Global.collectedVoters)
	#waffle_character_label.text = str(Global.waffles)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
