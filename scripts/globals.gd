extends Node

var dialogue_open: bool
var minigame_open: bool
var overscreen_present: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialogue_open = false
	minigame_open = false
	overscreen_present = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
