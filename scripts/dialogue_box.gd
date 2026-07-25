extends Node2D

# structure:
# "Conversation Id": [
#     ["SpeakerName", "Speaker's dialogue"]
# ]
const CONVERSATION_DICT = {
	"Start Game": [
		[]
	],
	"MailGuyStart": [
		["Player", "Hey, do you have the champagne delivery?"],
		["MailGuy", "Uh, yeah. I think it's here somewhere..."],
		["Player", "Great, can you give it to me to give it to the bosses?"],
		["MailGuy", "Uh, sure, but, I gotta sort through all this junk mail, and fanmail, and federal notices, and"],
		["Player", "ARGH! JUST LET ME DO IT!"]
	]
}
const CONVERSATION_COLORS = {
	"Player": Color(0.896, 0.715, 0.0, 1.0),
	"MailGuy": Color(0.0, 0.67, 0.738, 1.0),
	"Janitor": Color(0.0, 0.0, 0.0, 1.0),
	"Mechanic": Color(0.0, 0.0, 0.0, 1.0),
	"IT": Color(0.0, 0.0, 0.0, 1.0),
	"Guard": Color(0.0, 0.0, 0.0, 1.0),
	"CEO": Color(0.0, 0.0, 0.0, 1.0),
}
var active_convo: Array
var active: bool
var convo_index: int:
	set(value):
		convo_index = value
		if convo_index < len(active_convo):
			show_dialogue(active_convo[value][1], CONVERSATION_COLORS[active_convo[value][0]])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	active = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active and Input.is_action_just_pressed("ContinueDialogue"):
		convo_index += 1
		if convo_index >= len(active_convo):
			close()
	
func start_convo(id):
	active_convo = CONVERSATION_DICT[id]
	convo_index = 0
	open()
	
func show_dialogue(text, color):
	#$Sprite2D.call('modulate', color)
	$Control/RichTextLabel.text = text
	animate_dialogue()

func animate_dialogue():
	var text_tween = create_tween()
	$Control/RichTextLabel.visible_ratio = 0.0
	text_tween.tween_property($Control/RichTextLabel, "visible_ratio", 1.0, 1.0)

func open():
	active = true
	print("Open")
	
func close():
	active = false
	print("Close")
