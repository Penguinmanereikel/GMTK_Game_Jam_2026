extends Interactable

signal start_minigame(id)

func _interact():
	start_minigame.emit("CardScan")
