extends Interactable

signal start_dialogue(id)

func _interact():
	start_dialogue.emit("ServerRoom")
	update_interactables.emit("ServerRoom")
