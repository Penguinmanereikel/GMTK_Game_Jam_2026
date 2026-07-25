extends Interactable

signal minigame_start(id)

func _interact():
	minigame_start.emit("cooking_minigame")
