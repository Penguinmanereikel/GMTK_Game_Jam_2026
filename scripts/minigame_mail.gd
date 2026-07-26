extends Node2D

signal end_minigame(id)
signal start_dialogue(id)

var curr_dragging: Node2D = null
var dragToAreaDict: Dictionary = {}

var mail_scene: PackedScene = preload("res://scenes/mail.tscn")

var stored_away: int
var total_to_store: int

var curr_dragging_touching: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_mail(26*4)
	#spawn_mail(1)
	for draggable in $Draggables.get_children():
		draggable.connect('clicked', clicked_object)
		draggable.connect('unclicked', unclicked_object)
		draggable.connect('entered_area', dragged_to_DragToArea)
		draggable.connect('exited_area', dragged_away_from_DragToArea)
	for dragToArea in $DragToArea.get_children():
		dragToAreaDict[dragToArea] = dragToArea.name.split("_")[1]
	stored_away = 0
	total_to_store = $Draggables.get_child_count()
	curr_dragging_touching = []
	
func spawn_mail(num: int):
	var x_pos
	var y_pos
	for i in range(num):
		x_pos = randi_range($Marker_TL.position.x, $Marker_BR.position.x)
		y_pos = randi_range($Marker_TL.position.y, $Marker_BR.position.y)
		
		var mail = mail_scene.instantiate()
		mail.position = Vector2(x_pos,y_pos)
		mail.set_letter(char(65 + (i%26))) # label mail from A to Z
		$Draggables.add_child(mail)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func clicked_object(obj):
	if curr_dragging == null:
		curr_dragging = obj
		curr_dragging.is_dragging = true
		
func unclicked_object(obj):
	if obj == curr_dragging:
		if curr_dragging != null:
			check_DragToAreas()
			curr_dragging.is_dragging = false
			curr_dragging = null
		
func check_DragToAreas():
	for area in curr_dragging_touching:
		if dragToAreaDict[area] == curr_dragging.letter:
			drop_on_area(curr_dragging, area)
			$AudioStreamPlayer.play()
			check_finish_condition()
			
func drop_on_area(draggable, dragToArea):
	draggable.position = dragToArea.global_position
	draggable.diable_dragging()
	stored_away += 1
		
func dragged_to_DragToArea(area):
	print("dragged to area")
	curr_dragging_touching.append(area)
	
func dragged_away_from_DragToArea(area):
	print("dragged away from area")
	curr_dragging_touching.erase(area)

func start():
	print("Started minigame, minigame mail")
	
func finish():
	print("Finished minigame, minigame mail")
	$AudioStreamPlayer2.play()
	start_dialogue.emit("MailGuyEnd")
	end_minigame.emit("MailRoom")
	
func check_finish_condition():
	if stored_away >= total_to_store:
		finish()
