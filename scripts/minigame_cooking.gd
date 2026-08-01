extends Node2D

signal end_minigame(id)
signal start_dialogue(id)

var running: int = false
var tween: Tween
@export var movement_curve: Curve

func _process(_delta):
	if $Path2D/PathFollow2D.progress_ratio < 0.62:
		$AnimatedSprite2D.frame = 0
	elif $Path2D/PathFollow2D.progress_ratio >= 0.62 and $Path2D/PathFollow2D.progress_ratio <= 0.68:
		$AnimatedSprite2D.frame = 1
	elif $Path2D/PathFollow2D.progress_ratio > 0.68:
		$AnimatedSprite2D.frame = 2
		
	if $Path2D/PathFollow2D.progress_ratio >= 1.0:
		fail()

func clicked_button(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not running:
			running = true
			start_cooking()
		else:
			tween.stop()
			if $Path2D/PathFollow2D.progress_ratio >= 0.62 and $Path2D/PathFollow2D.progress_ratio <= 0.68:
				finish()
			else:
				fail()
				
func start_cooking():
	tween = create_tween()
	$Sounds/AudioStreamPlayer2.play()
	tween.tween_method(move_arrow, 0.0, 1.0, 4.0)
	#tween.tween_property($Path2D/PathFollow2D, "progress_ratio", 1.0, 4.0)

func move_arrow(pos):
	$Path2D/PathFollow2D.progress_ratio = movement_curve.sample(pos)


func start():
	print("Started minigame, minigame cooking")

func finish():
	print("Finished minigame, minigame cooking")
	$Sounds/AudioStreamPlayer2.stop()
	$Sounds/AudioStreamPlayer.play()
	start_dialogue.emit("Oven")
	end_minigame.emit("Cooking")

func fail():
	print("Fail")
	$Sounds/AudioStreamPlayer2.stop()
	$Sounds/AudioStreamPlayer3.play()
	$Path2D/PathFollow2D.progress_ratio = 0.0
	running = false
	
