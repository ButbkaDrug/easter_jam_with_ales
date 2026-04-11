extends CharacterBody2D

var target: Vector2 = Vector2(320, 200)

var hp = 10
var speed = 30

var direction: Vector2

@onready var _animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var _collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready():
	_animated_sprite_2d.play("vertical_walk")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	direction = position.direction_to(target)
	velocity = direction * speed * delta

	var is_collision = move_and_collide(velocity)

	if is_collision: 
		if is_collision.get_collider().name == "Player":
			speed = 0
			hp = 0
			
func _process(delta: float) -> void:
	if hp <= 0:
		_animated_sprite_2d.play("death")
