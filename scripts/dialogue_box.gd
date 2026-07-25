extends Node2D

signal start_minigame(id)

# structure:
# "Conversation Id": [
#     ["SpeakerName", "Speaker's dialogue"]
# ]
const CONVERSATION_DICT = {
	"StartGame": [
		["Player", "Man, I should be watching today's rocket launch, but it feels good to look back on my work"],
		#["Player", "To think, all of my calculations and equations made today possible."],
		#["Player", "I'll probably get promoted for this!"],
		#["Player", "..."],
		#["Player", "Wait"],
		#["Player", "OH, CRAP! I forgot to carry the 1 here!"],
		#["Player", "By my calculations, the ship needs like 40 extra pounds onboard or it'll crash!"],
		#["Player", "Dangit! I can't let anyone find out about this. I gotta find some heavy stuff and sneak it onboard!"],
		#["Player", "I should be able to find something upstairs in the storage room..."],
		["END", ""],
	],
	"MailGuyStart": [
		["Player", "Hey, do you have the champagne delivery?"],
		#["MailGuy", "Uh, yeah. I think it's here somewhere..."],
		#["Player", "Great, can you give it to me to give it to the bosses?"],
		#["MailGuy", "Uh, sure, but, I gotta sort through all this junk mail, and fanmail, and federal notices, and..."],
		#["Player", "ARGH! JUST LET ME DO IT!"],
		["MINIGAME", "MailRoom"]
	]
}
const CONVERSATION_COLORS = {
	"Player": Color(0.896, 0.715, 0.0, 1.0),
	"MailGuy": Color(0.0, 0.67, 0.738, 1.0),
	"Janitor": Color(0.843, 0.419, 0.0, 1.0),
	"Mechanic": Color(0.088, 0.488, 1.0, 1.0),
	"IT": Color(0.733, 0.0, 0.708, 1.0),
	"Guard": Color(0.959, 0.023, 0.0, 1.0),
	"CEO": Color(0.0, 0.869, 0.246, 1.0),
}
var active_convo: Array
var active: bool
var convo_index: int

const OPEN_POSITION_Y: float = 539.0
const CLOSE_POSITION_Y: float = 789.0

signal end_dialogue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	active = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active and Input.is_action_just_pressed("ContinueDialogue"):
		convo_index += 1
		if active_convo[convo_index][0] == "END":
			close()
			end_dialogue.emit()
		elif active_convo[convo_index][0] == "MINIGAME":
			start_minigame.emit(active_convo[convo_index][1])
			close()
			end_dialogue.emit()
		else:
			show_dialogue(active_convo[convo_index][1], CONVERSATION_COLORS[active_convo[convo_index][0]])
	
func start_convo(id):
	active_convo = CONVERSATION_DICT[id]
	convo_index = 0
	open()
	show_dialogue(active_convo[0][1], CONVERSATION_COLORS[active_convo[0][0]])
	
func show_dialogue(text, color):
	print("called")
	$Sprite2D.set_modulate(color)
	$Control/RichTextLabel.text = text
	animate_dialogue()

func animate_dialogue():
	var text_tween = create_tween()
	$Control/RichTextLabel.visible_ratio = 0.0
	active = false
	text_tween.tween_property($Control/RichTextLabel, "visible_ratio", 1.0, 1.0)
	text_tween.finished.connect(func (): active = true)

func open():
	print("Open")
	active = true
	var box_tween = create_tween()
	box_tween.tween_property($".", "position:y", OPEN_POSITION_Y, 0.25)
	
	
func close():
	print("Close")
	active = false
	var box_tween = create_tween()
	box_tween.tween_property($".", "position:y", CLOSE_POSITION_Y, 0.25)
