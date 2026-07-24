extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	wire_up_stairs_signals()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func wire_up_stairs_signals():
	for stairs_scene in $LevelMap/StairsSet.get_children():
		stairs_scene.connect('take_stairs', take_stairs)
		
func take_stairs(dest: Vector2):
	$Player.global_position = dest
