extends Interactable

signal start_dialogue(id)

func _interact():
	print("Interacted with MailGuy")
	$Area2D.process_mode = Node.PROCESS_MODE_DISABLED
	start_dialogue.emit("MailGuyStart")
