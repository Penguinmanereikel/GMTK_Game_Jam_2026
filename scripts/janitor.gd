extends Interactable

signal start_dialogue(id)

func _interact():
	start_dialogue.emit("JanitorStart")
	
