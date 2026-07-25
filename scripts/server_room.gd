extends Interactable

signal update_interactables(id)

func _interact():
	update_interactables.emit("ServerRoom")
