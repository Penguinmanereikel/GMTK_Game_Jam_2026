extends CharacterBody2D

@export var playerSpeed = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Left"):
		self.position.x -= playerSpeed * delta
	if Input.is_action_pressed("Right"):
		self.position.x += playerSpeed * delta
