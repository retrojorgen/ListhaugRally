extends CanvasLayer
@onready var main_character_label: Label = $MainCharacterLabel
@onready var picker_character_label: Label = $PickerCharacterLabel
@onready var booth_character_label: Label = $BoothCharacterLabel
@onready var waffle_character_label: Label = $WaffleCharacterLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		get_tree().get_root().get_node("Game").values.connect(updateValues)
		updateValues()

func updateValues():
	main_character_label.text = str(Global.lives)
	picker_character_label.text = str(Global.voters)
	booth_character_label.text = str(Global.collectedVoters)
	waffle_character_label.text = str(Global.waffles)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
