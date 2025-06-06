extends Node2D
@onready var screen_size = get_viewport_rect().size

var is_invincible := false
#global scripts
var speed := 400
var lives := 10;
var voters := 0;
var waffles := 10;
var collectedVoters = 0;

const BOTTOM_OF_TRACK = 200
const TOP_OF_TRACK = -160
const LEFT_OF_TRACK = -420
const RIGHT_OF_TRACK = 420
