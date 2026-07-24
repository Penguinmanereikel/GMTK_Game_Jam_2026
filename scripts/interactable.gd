class_name Interactable
extends Node2D

var active: bool = false

func _process(delta):
	if active and Input.is_action_just_pressed("Interact"):
		_interact()

func _interact():
	push_error("Interaction behavior not defined")

func _make_active(_body: Node2D):
	print("Entered")
	active = true
	
func _make_inactive(_body: Node2D):
	print("Exited")
	active = false
