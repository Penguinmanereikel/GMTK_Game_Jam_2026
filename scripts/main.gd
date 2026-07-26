extends Node2D

@onready var MINIGAME_DICT: Dictionary = {
	"MailRoom": $Minigame/Minigame_Mail,
	"CardSwipe": $Minigame/Minigame_Card,
	"Cooking": $Minigame/Minigame_Cooking,
	"Storage": $Minigame/Minigame_Storage,
	"Computer": $Minigame/Minigame_Computer
}
var game_over: int

# Called when the node enters the scene tree for the first time.
func _ready():
	wire_up_stairs_signals()
	wire_up_conversation_starters()
	start_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_over and Input.is_key_pressed(KEY_SPACE):
		get_tree().reload_current_scene()
		
func start_game():
	$MusicManager.play_music("Gameplay")
	start_dialogue('StartGame')
	$LevelMap.update_interactables('init')

func wire_up_stairs_signals():
	for stairs_scene in $LevelMap/StairsSet.get_children():
		stairs_scene.connect('take_stairs', take_stairs)
		
func take_stairs(dest: Vector2):
	$Player.global_position = dest

func start_dialogue(id: String):
	Globals.dialogue_open = true
	$Conversation/DialogueBox.start_convo(id)
	
func end_dialogue():
	Globals.dialogue_open = false
	
func wire_up_conversation_starters():
	for node in get_tree().get_nodes_in_group('ConversationStarters'):
		print(node)
		node.connect('start_dialogue', start_dialogue)
	
func start_minigame(id):
	var minigame_scene: Node2D = MINIGAME_DICT[id]
	Globals.minigame_open = true
	minigame_scene.visible = true
	print("Started minigame, main")
	minigame_scene.start()
	
func end_minigame(id):
	print("Ended minigame, main")
	var minigame_scene:Node2D = MINIGAME_DICT[id]
	Globals.minigame_open = false
	minigame_scene.visible = false
	print(Globals.minigame_open)
	$LevelMap.update_interactables(id)
	if id == "CardSwipe":
		win()
		
func win():
	Globals.overscreen_present = true
	print("Win")
	$MusicManager/WinMusic.play()
	print("Show Win Screen")
		
func lose():
	Globals.overscreen_present = true
	print("Game Over")
	print("Show Game Over Screen")
	$MusicManager/GameOverMusic.play()
	game_over = true
