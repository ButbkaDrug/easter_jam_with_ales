extends Node2D

@onready var _animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var hp = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_animated_sprite_2d.play("idle")
	pass
