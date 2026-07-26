extends Interactable

signal minigame_start(id)

func _interact():
	print("Oven interacted with")
	minigame_start.emit("Cooking")
