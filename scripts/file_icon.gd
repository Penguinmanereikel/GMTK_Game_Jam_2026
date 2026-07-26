extends Node2D

signal clicked_delete(obj)

func file_delete_clicked(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("clicked")
		clicked_delete.emit(self)
