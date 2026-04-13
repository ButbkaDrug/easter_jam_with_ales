extends CharacterBody2D

const DEFAULT_SPEED = 20
var health:int = 100
var speed: int = DEFAULT_SPEED
var direction: Vector2

# @onready var _animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var _collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var _animation_player: AnimationPlayer = $AnimationPlayer
@onready var _sprite: Sprite2D = $Sprite2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

func _ready():
	# _animated_sprite_2d.play("vertical_walk")
	_animation_player.play("walk")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_dead():
		return

	if _sprite.frame < 2:
		speed = 0
	else:
		speed = DEFAULT_SPEED

	var target_position: Vector2 = self.global_position

	if player:
		target_position = player.global_position
		

	
	var direction: Vector2 = position.direction_to(target_position)
	velocity = direction * speed * delta

	var is_collision: KinematicCollision2D = move_and_collide(velocity)

	if is_collision: 
		if is_collision.get_collider().name == "Player":
			speed = 0

func _process(delta: float) -> void:
	if is_dead() && _animation_player.current_animation != "death":
		_animation_player.play("death")

	if !visible:
		free()



func take_damage(damage: int):
	health -= damage
	if health <= 0:
		health = 0

func is_dead() -> bool:
	return health <= 0


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		_animation_player.stop()
		self.visible = false
