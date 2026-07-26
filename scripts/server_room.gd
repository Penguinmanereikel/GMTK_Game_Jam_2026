extends Interactable


func _interact():
	update_interactables.emit("ServerRoom")
