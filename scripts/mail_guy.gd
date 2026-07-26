extends Interactable

signal start_dialogue(id)

func _interact():
	print("Interacted with MailGuy")
	start_dialogue.emit("MailGuyStart")
	update_interactables.emit("ceo_conversation")
