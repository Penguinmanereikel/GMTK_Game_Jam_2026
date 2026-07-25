extends Node2D

var MINIGAME_DICT: Dictionary = {
	"MailRoom": $Minigame/Minigame_Mail,
	"CardSwipe": $Minigame/Minigame_Card
}
var game_over: int

# Called when the node enters the scene tree for the first time.
func _ready():
	wire_up_stairs_signals()
	wire_up_conversation_starters()
	start_dialogue('StartGame')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_over and Input.is_key_pressed(KEY_SPACE):
		get_tree().reload_current_scene()

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
	var minigame_scene = MINIGAME_DICT[id]
	var minigame = minigame_scene.instantiate()
	$Minigame.add_child(minigame)
	Globals.minigame_open = true
	
func end_minigame(id):
	$Minigame.get_child(0).queue_free()
	Globals.minigame_open = false
	$LevelMap.update_interactables(id)
		
func win():
	print("Win")
	print("Play Win Music")
	print("Show Win Screen")
		
func lose():
	print("Game Over")
	print("Show Game Over Screen")
	print("Play Game Over Music")
	game_over = true
