extends Node2D

signal end_minigame(id)
signal start_dialogue(id)

var package_scene: PackedScene = preload("res://scenes/package.tscn")

var clicked: int = 0
@export var target: int = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawn_box():
	var package = package_scene.instantiate()
	package.position.x = randi_range($Marker_L.position.x, $Marker_R.position.x)
	package.position.y = $Marker_L.position.y
	package.connect('clicked_on',clicked_box)
	$Packages.add_child(package)
	print("box spawned")
	
func start_timer():
	$Timer.start()

func start():
	print("Started minigame, minigame storage")
	visible = true
	start_timer()

func finish():
	print("Finished minigame, minigame storage")
	visible = false
	$Timer.stop()
	start_dialogue.emit("JanitorEnd")
	end_minigame.emit("Storage")

func clicked_box(obj):
	clicked += 1
	obj.queue_free()
	$Label.text = "Catch " + str(target - clicked) + " boxes"
	if clicked >= target:
		finish()
