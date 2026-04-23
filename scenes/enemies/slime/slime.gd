extends CharacterBody2D

const DEFAULT_SPEED = 20
var health:int = 100
var max_health:int = 100
var speed: int = DEFAULT_SPEED
var points: int = 10
var direction: Vector2

signal defeated(points: int)

# @onready var _animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var _collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var _animation_player: AnimationPlayer = $AnimationPlayer
@onready var _sprite: Sprite2D = $Sprite2D
@onready var _navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var _health_bar = $HealthBar

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

func _ready():
	# _animated_sprite_2d.play("vertical_walk")
	_animation_player.play("walk")
	_navigation_agent.target_position = player.global_position
	print("navigation position set:", _navigation_agent.target_position)


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_dead():
		return

	if _navigation_agent.is_navigation_finished():
		return



	if _sprite.frame < 2:
		speed = 0
	else:
		speed = DEFAULT_SPEED

	var next_pos:Vector2 = _navigation_agent.get_next_path_position()
	velocity = global_position.direction_to(next_pos) * speed
	move_and_slide()


	
	# var direction: Vector2 = position.direction_to(target_position)
	# velocity = direction * speed * delta



	# var is_collision: KinematicCollision2D = move_and_collide(velocity)

	# if is_collision: 
	# 	if is_collision.get_collider().name == "Player":
	# 		speed = 0

func _process(delta: float) -> void:
	if is_dead() && _animation_player.current_animation != "death":
		_animation_player.play("death")

	if !visible:
		defeated.emit(points)
		queue_free()



func take_damage(damage: int):
	health -= damage
	if health <= 0:
		health = 0
	
	_health_bar.update(health, max_health)

	GameData.enemy_hit.emit(damage, global_position)

func is_dead() -> bool:
	return health <= 0


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		_animation_player.stop()
		self.visible = false


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()
	pass # Replace with function body.
