extends Node2D
@onready var screen_size = get_viewport_rect().size

var is_invincible := false
#global scripts
var is_jumping := false

var previousSpeed := 600
var speed := 600
var lives := 10;
var voters := 0;
var waffles := 1;
var collectedVoters = 0;

const BOTTOM_OF_TRACK = 200
const TOP_OF_TRACK = -160
const LEFT_OF_TRACK = -420
const RIGHT_OF_TRACK = 420


const TOP_OF_LEVEL = -200
