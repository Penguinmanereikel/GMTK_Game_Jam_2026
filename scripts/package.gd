extends Node2D

var velocity = Vector2.ZERO
var gravity = 30000
signal clicked_on(obj)
	
func _process(delta: float) -> void:
	if position.y > 800:
		queue_free()

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	print(velocity)
	position.y = velocity.y * delta
	print(position)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		clicked_on.emit(self)
