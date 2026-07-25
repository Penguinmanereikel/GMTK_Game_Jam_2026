extends CharacterBody2D

@export var playerSpeed = 20
var dir: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dir = 0
	if Input.is_action_pressed("Left"):
		dir -= 1
	if Input.is_action_pressed("Right"):
		dir += 1
	
	print(dir)
	print((playerSpeed * delta) * dir)
	self.position.x += (playerSpeed * delta) * dir
	
	if dir == 0:
		$AnimatedSprite2D.play('Idle')
	elif dir < 0:
		if scale.x > 0:
			scale.x *= -1
		$AnimatedSprite2D.play("Walk")
	elif dir > 0:
		if scale.x < 0:
			scale.x *= -1
		$AnimatedSprite2D.play("Walk")
	
