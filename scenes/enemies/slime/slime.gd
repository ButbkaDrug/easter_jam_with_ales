extends CharacterBody2D

var hp = 10
var speed = 30
const DEFAULT_SPEED = 30

var direction: Vector2
@export var target_position: Vector2 = Vector2(0,0)

@onready var _animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var _collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var _animation_player: AnimationPlayer = $AnimationPlayer
@onready var _sprite: Sprite2D = $Sprite2D

@onready var player: StaticBody2D = get_tree().get_first_node_in_group("Player")

func _ready():
	_animated_sprite_2d.play("vertical_walk")
	_animation_player.play("walk")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:

	if _sprite.frame < 2:
		speed = 0
	else:
		speed = DEFAULT_SPEED
	
	direction = position.direction_to(target_position)
	velocity = direction * speed * delta

	var is_collision = move_and_collide(velocity)

	if is_collision: 
		if is_collision.get_collider().name == "Player":
			speed = 0

func _process(delta: float) -> void:
	if hp <= 0 && _animated_sprite_2d.animation != "death":
		_animated_sprite_2d.play("death")

	if !_animated_sprite_2d.is_playing():
		get_tree().reload_current_scene()

func _on_animated_sprite_2d_animation_looped() -> void:
	if speed == 0:
		player.hp -= 10
