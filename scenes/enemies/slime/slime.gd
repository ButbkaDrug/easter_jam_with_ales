extends CharacterBody2D

var target: Vector2 = Vector2(320, 200)

var hp = 10
var speed = 10

var direction: Vector2

@onready var _animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction = position.direction_to(target)
	velocity = direction * speed

	move_and_slide()
