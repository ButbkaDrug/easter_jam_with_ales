extends Node2D

@onready var _tower: AnimatedSprite2D = $Tower
@onready var _archer: AnimatedSprite2D = $Archer

var hp = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_tower.play("idle")
	_archer.play("idle")
	pass
