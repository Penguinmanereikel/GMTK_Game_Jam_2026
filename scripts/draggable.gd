class_name Draggable
extends Node2D

signal clicked(obj)
signal unclicked(obj)
signal entered_area(area)
signal exited_area(area)

var is_dragging: bool
var dragging_enabled: bool
var offset = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	is_dragging = false
	dragging_enabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_dragging:
		position = get_global_mouse_position() + offset

func clicked_on(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			offset = position - get_global_mouse_position()
			clicked.emit(self)
		elif is_dragging and not event.pressed:
			offset = position - get_global_mouse_position()
			unclicked.emit(self)

func enable_dragging():
	dragging_enabled = true
	$Area2D.input_pickable = true

func diable_dragging():
	dragging_enabled = false
	$Area2D.input_pickable = false

func _on_area_2d_area_entered(area):
	entered_area.emit(area)
	
func _on_area_2d_area_exited(area):
	exited_area.emit(area)
