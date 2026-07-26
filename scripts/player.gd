extends CharacterBody2D

@export var playerSpeed = 20
var dir: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dir = 0
	print($AnimatedSprite2D.scale.x)
	#print("Player status: ", Globals.dialogue_open, " ", Globals.minigame_open)
	if Globals.dialogue_open == false and Globals.minigame_open == false and Globals.overscreen_present == false:
		if Input.is_action_pressed("Left"):
			dir -= 1
		if Input.is_action_pressed("Right"):
			dir += 1
		if Input.is_action_just_pressed("Left") and $AnimatedSprite2D.scale.x > 0:
			print("HIT LEFT")
			$AnimatedSprite2D.scale.x *= -1
		if Input.is_action_just_pressed("Right") and $AnimatedSprite2D.scale.x < 0:
			print("HIT RIGHT")
			$AnimatedSprite2D.scale.x *= -1
		
		#print((playerSpeed * delta) * dir)
		velocity.x = playerSpeed * dir
		move_and_slide()
		
		#print("DIR: ", dir)
		if dir == 0:
			$AnimatedSprite2D.play('Idle')
		elif dir < 0:
			$AnimatedSprite2D.play("Walk")
		elif dir > 0:
			$AnimatedSprite2D.play("Walk")
	
