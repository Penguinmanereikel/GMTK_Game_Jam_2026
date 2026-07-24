extends Node

# structure:
# "Conversation Id": [
#     ["SpeakerName": "Speaker's dialogue"]
# ]
const CONVERSATION_DICT = {
	"Start Game": [
		[]
	]
}
const CONVERSATION_COLORS = {
	"Player": Color(0.896, 0.715, 0.0, 1.0),
	"MailGuy": Color(0.0, 0.0, 0.0, 1.0),
	"Janitor": Color(0.0, 0.0, 0.0, 1.0),
	"Mechanic": Color(0.0, 0.0, 0.0, 1.0),
	"IT": Color(0.0, 0.0, 0.0, 1.0),
	"Guard": Color(0.0, 0.0, 0.0, 1.0),
	"CEO": Color(0.0, 0.0, 0.0, 1.0),
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
