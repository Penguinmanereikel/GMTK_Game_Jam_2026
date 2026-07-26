extends Node2D

signal end_minigame(id)
signal start_dialogue(id)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start():
	print("Started minigame, minigame storage")
	visible = true
	finish()

func finish():
	print("Finished minigame, minigame storage")
	visible = false
	start_dialogue.emit("JanitorEnd")
	end_minigame.emit("Storage")
