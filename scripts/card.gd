extends Draggable

const MIN_X: int = 194
const MAX_X: int = 958

var new_x: int

func _process(_delta):
	
	
	if is_dragging:
		new_x = get_global_mouse_position().x + offset.x
		if new_x >= MIN_X and new_x <= MAX_X:
			position.x = new_x

func mouse_left():
	if is_dragging:
		unclicked.emit(self)
