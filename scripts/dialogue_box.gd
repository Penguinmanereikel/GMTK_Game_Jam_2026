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
		#["Player", "I should be able to find something down the hall in the storage room..."],
		["END", ""],
	],
	"JanitorStart": [
		["Player", "Hey, Mister uh... Janitor... guy..."],
		#["Janitor", "It's Morris."],
		#["Player", "Right, you wouldn't happen to have something super heavy that we don't need in storage, do you?"],
		#["Janitor", "Maybe. What's it to you?"],
		#["Player", "It's just that I really need it. Could you help me out?"],
		#["Janitor", "Only if you can help me with all these boxes."],
		#["Player", "Ugh, fine, but make it quick."],
		["MINIGAME", "Storage"]
	],
	"JanitorEnd": [
		["Player", "Great. Got a huge box full of metal junk. But I'll need more"],
		#["Player", "Maybe I can find something from the ship mechanic. She should be upstairs."],
		["END", ""]
	],
	"MechanicStart": [
		["Player", "Hey, there. I need your help."],
		#["Mechanic", "Hey, it's you! Big day, huh? All our hard work ready to pay off."],
		#["Player", "Right... Yeah, big day..."],
		#["Player", "Anyway, I have a favor to ask. Could you get me something really heavy?"],
		#["Mechanic", "How heavy?"],
		#["Player", "As heavy as you can get."],
		#["Mechanic", "Hmm... I might have something. But I can't just give you ship parts for free."],
		#["Mechanic", "Tell you what. How about you get me some pizza from the break room, and I'll give it to you, no questions asked"],
		#["Player", "Fine. I'll go upstairs and get you a pizza."],
		["END", ""]
	],
	"Oven": [
		["Player", "Alright, now just need to bring it back down to her."],
		["END", ""]
	],
	"MechanicEnd": [
		["Mechanic", "Heck, yeah. Pizza!"],
		#["Player", "And what about what I need?"],
		#["Mechanic", "Yeah, yeah. A deal's a deal. Here you go, a loaded liquid tank. Should be heavy enough"],
		#["Player", "That's pretty good, but I'm gonna need at least one more thing."],
		#["Player", "The next heaviest thing here is probably going to be an old server from the server room."],
		#["Player", "I'll have to go upstairs to get the code for the door."],
		["END", ""]
	],
	"ITGuyStart": [
		["ITGuy", "Oh, hey. You need something?"],
		["Player", "In fact, I do. I need access to the server room."],
		["ITGuy", "Well, the code is randomized every day, so I have to check on my email."],
		["Player", "And what does it say?"],
		["ITGuy", "Hold on... I gotta update my email app, but it's giving me issues."],
		["ITGuy", "Let's see.... it says my computer does not have enough space and requires me to make space..."],
		["Player", "Let me have a look! I'll get this done quicker!"],
		["MINIGAME", "Computer"]
	],
	"ITGuyEnd": [
		["Player", "Done! And I got the code! Now I just need to go downstairs and open it!"],
		["END", ""]
	],
	"ServerRoom": [
		["Player", "Oh, nuts. This thing is heeeeaaaavyyyy. This should be good for weight."],
		["Player", "Now, I know that only the astronauts and certain company VIPs are allowed to even open the ship door."],
		["Player", "So I'll need a VIP card to get on."],
		["Player", "The CEO should have one, and he should be on the roof right now."],
		["END", ""]
	],
	"CEOStart": [
		["Player", "Good morning, sir!"],
		["CEO", "Are you the champagne boy?"],
		["Player", "Uh, no, sir. I'm...."],
		["CEO", "I want my champagne before I talk to anyone."],
		["Player", "But sir...."],
		["CEO", "It's a big day for me, and I want to celebrate it."],
		["CEO", "I want my champagne. I ordered it yesterday, it should be here now."],
		["Player", "Ugh, I'll... go back to the ground floor and check the mail room..."],
		["END", ""]
	],
	"MailGuyStart": [
		["Player", "Hey, do you have the champagne delivery?"],
		["MailGuy", "Uh, yeah. I think it's here somewhere..."],
		["Player", "Great, can you give it to me to give it to the bosses?"],
		["MailGuy", "Uh, sure, but, I gotta sort through all this junk mail, and fanmail, and federal notices, and..."],
		["Player", "ARGH! JUST LET ME DO IT!"],
		["MINIGAME", "MailRoom"]
	],
	"MailGuyEnd": [
		["Player", "Got it! Now I just have to bring this back up to the CEO."],
		["END", ""]
	],
	"CEOEnd": [
		["Player", "Your champagne, sir?"],
		["CEO", "Perfect!"],
		["CEO", "glug glug glug"],
		["Player", "Uh, boss?"],
		["CEO", "glug glug glug"],
		["CEO", "Yeah! I'm launching a rocket today!"],
		["Player", "Uh... let me check nick it from his VIP card from his back pocket"],
		["Player", "Got it. Now I can open the rocket doors!"],
		["Player", "The rocket should be all the way on the right then..."],
		["END", ""]
	],
}
const CONVERSATION_COLORS = {
	"Player": Color(0.855, 0.682, 0.0, 1.0),
	"MailGuy": Color(0.0, 0.752, 0.828, 1.0),
	"Janitor": Color(0.998, 0.502, 0.0, 1.0),
	"Mechanic": Color(0.573, 0.746, 1.0, 1.0),
	"ITGuy": Color(1.0, 0.345, 0.963, 1.0),
	"CEO": Color(1.0, 0.369, 0.38, 1.0),
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
			print("dialogue box close: convo ended")
			close()
			end_dialogue.emit()
		elif active_convo[convo_index][0] == "MINIGAME":
			print("dialogue box close: starting minigame")
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
	print("Open Dialogue")
	active = true
	var box_tween = create_tween()
	box_tween.tween_property($".", "position:y", OPEN_POSITION_Y, 0.25)
	
	
func close():
	print("Close Dialogue, dialogue box, close()")
	active = false
	var box_tween = create_tween()
	box_tween.tween_property($".", "position:y", CLOSE_POSITION_Y, 0.25)
