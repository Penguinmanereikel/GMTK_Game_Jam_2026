extends Interactable

signal start_dialogue(id)
var had_first_talk: bool = false

func _interact():
	if not had_first_talk:
		had_first_talk = true
		start_dialogue.emit("CEOStart")
		update_interactables.emit("ceo_conversation")
	else:
		start_dialogue.emit("CEOEnd")
		update_interactables.emit("ceo_conversation2")
