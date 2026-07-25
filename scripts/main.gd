extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	wire_up_stairs_signals()
	wire_up_conversation_starters()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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
	
	
