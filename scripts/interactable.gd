class_name Interactable
extends Node2D

signal update_interactables(id)

var active: bool = false

func _ready() -> void:
	$Control/Label.set('visible', false)

func _process(delta):
	if not Globals.dialogue_open and active and Input.is_action_just_pressed("Interact"):
		_interact()

func _interact():
	push_error("Interaction behavior not defined")

func _make_active(_body: Node2D):
	print("Activated ", self)
	$Control/Label.set('visible', true)
	active = true
	
func _make_inactive(_body: Node2D):
	print("Deactivated ", self)
	$Control/Label.set('visible', false)
	active = false
