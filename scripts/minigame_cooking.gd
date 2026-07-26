extends Node2D

signal end_minigame(id)
signal start_dialogue(id)

var running: int = false
var tween: Tween
@export var movement_curve: Curve

func _process(_delta):
	if $Path2D/PathFollow2D.progress_ratio >= 1.0:
		fail()

func clicked_button(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not running:
			running = true
			start_cooking()
		else:
			tween.stop()
			if $Path2D/PathFollow2D.progress_ratio >= 0.8 and $Path2D/PathFollow2D.progress_ratio <= 0.822:
				finish()
			else:
				print("")
				fail()
				
func start_cooking():
	tween = create_tween()
	tween.tween_method(move_arrow, 0.0, 1.0, 4.0)
	#tween.tween_property($Path2D/PathFollow2D, "progress_ratio", 1.0, 4.0)

func move_arrow(pos):
	$Path2D/PathFollow2D.progress_ratio = movement_curve.sample(pos)


func start():
	print("Started minigame, minigame cooking")
	visible = true

func finish():
	print("Finished minigame, minigame cooking")
	visible = false
	start_dialogue.emit("Oven")
	end_minigame.emit("Cooking")

func fail():
	print("Fail")
	$Path2D/PathFollow2D.progress_ratio = 0.0
	running = false
	
