extends Node2D

@onready var _tower: AnimatedSprite2D = $Tower
@onready var _archer: AnimatedSprite2D = $Archer

@onready var _collision_shape_2d: CollisionShape2D = $CollisionShape2D

var hp = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_tower.play("idle")
	_archer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if hp <= 0 && _tower.animation != "death":
		_tower.play("death")


func _on_tower_animation_finished() -> void:
	if _tower.animation == "death":
		queue_free()
