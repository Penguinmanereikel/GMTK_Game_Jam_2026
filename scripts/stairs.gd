extends Interactable

@export var connected: Node2D
signal take_stairs(dest: Vector2)

func _interact():
	if connected:
		take_stairs.emit(connected.get_node("Marker2D").global_position)
