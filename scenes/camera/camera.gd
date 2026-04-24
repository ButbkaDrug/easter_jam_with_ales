extends Camera2D

var dragging: bool = false
var last_pos: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _unhandled_input(event):
	if event is InputEventScreenTouch:
		print("camera touch event detected")
		if event.pressed:
			dragging = true
			last_pos = event.position
		else:
			dragging = false

	elif event is InputEventScreenDrag and dragging:
		var delta = event.position - last_pos
		position -= delta * zoom  # important for correct scaling
		last_pos = event.position
