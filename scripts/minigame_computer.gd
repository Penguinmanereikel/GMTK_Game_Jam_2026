extends Node2D

signal end_minigame(id)
signal start_dialogue(id)

var file_scene: PackedScene = preload("res://scenes/file_icon.tscn")

var need_to_delete: float
var deleted: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deleted = 0
	spawn_files(40)
	connect_file_click()
	need_to_delete = $Files.get_child_count()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Window/ProgressBar.value == 100:
		finish()

func spawn_files(num):
	var file: Node2D
	var x_pos
	var y_pos
	for i in num:
		x_pos = randi_range($Marker_TL.position.x, $Marker_BR.position.x)
		y_pos = randi_range($Marker_TL.position.y, $Marker_BR.position.y)
		
		file = file_scene.instantiate()
		file.position = Vector2(x_pos,y_pos)
		$Files.add_child(file)
	
func connect_file_click():
	for file_node in $Files.get_children():
		file_node.connect('clicked_delete', deleted_file)

func start():
	print("Started minigame, minigame computer")
	#finish()
	
func finish():
	print("Finished minigame, minigame computer")
	$AudioStreamPlayer2.play()
	start_dialogue.emit("ITGuyEnd")
	end_minigame.emit("Computer")
	
func tween_progress(newVal):
	print(newVal)
	var t:Tween = create_tween()
	t.tween_property($Window/ProgressBar,'value', newVal*100, 1.0)

func deleted_file(obj):
	$AudioStreamPlayer.play()
	obj.queue_free()
	deleted += 1
	tween_progress(deleted/need_to_delete)
	
