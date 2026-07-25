extends Interactable

var had_first_talk = false

signal start_dialogue(id)
signal update_interactables(id)

func _interact():
	if not had_first_talk:
		had_first_talk = true
		print("Interacted with Mechanic")
		#$Area2D.process_mode = Node.PROCESS_MODE_DISABLED
		start_dialogue.emit("MechanicStart")
		update_interactables.emit("mechanic_conversation")
	else:
		print("Interacted with Mechanic")
		#$Area2D.process_mode = Node.PROCESS_MODE_DISABLED
		start_dialogue.emit("MechanicFinish")
		update_interactables.emit("mechanic_conversation2")
