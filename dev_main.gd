extends Node

@export var slime_scene: PackedScene

var timer: float = 0
var max_timer: float = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer >= max_timer:
		timer = 0
		var slime = slime_scene.instantiate()
		slime.position = Vector2(100, 50)
		add_child(slime)
