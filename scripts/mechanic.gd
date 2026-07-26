extends Interactable

var had_first_talk = false

signal start_dialogue(id)

func _interact():
	print("Interacted with Mechanic")
	if not had_first_talk:
		had_first_talk = true
		#$Area2D.process_mode = Node.PROCESS_MODE_DISABLED
		start_dialogue.emit("MechanicStart")
		update_interactables.emit("mechanic_conversation")
	else:
		#$Area2D.process_mode = Node.PROCESS_MODE_DISABLED
		start_dialogue.emit("MechanicEnd")
		update_interactables.emit("mechanic_conversation2")
