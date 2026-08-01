extends Node2D

var start_pos: Vector2
var target_dist: int
var start_time: int
@export var lower_time_range: int
@export var upper_time_range: int

signal end_minigame(id)

func _ready():
	start_pos = $Card.position
	target_dist = 940

func clicked_object(obj):
	obj.is_dragging = true
	start_time = Time.get_ticks_msec()
		
func unclicked_object(obj):
	print("unclicked")
	print(obj.position.x)
	print(target_dist)
	var elapsed_time: int = Time.get_ticks_msec() - start_time
	obj.is_dragging = false
	if obj.position.x >= target_dist:
		print(elapsed_time)
		if elapsed_time >= lower_time_range and elapsed_time <= upper_time_range:
			finish()
		elif elapsed_time < lower_time_range:
			$Display/Label.text = "Swipe faster"
			$Node/AudioStreamPlayer.play()
		elif elapsed_time > upper_time_range:
			$Display/Label.text = "Swipe slower"
			$Node/AudioStreamPlayer.play()
	else:
		$Display/Label.text = "Swipe all the way"
		$Node/AudioStreamPlayer.play()
	$Card.position = start_pos

func start():
	print("Started minigame, minigame card")
	show()

func finish():
	$Node/AudioStreamPlayer2.play()
	print("Finished minigame, minigame card")
	hide()
	end_minigame.emit("CardSwipe")
