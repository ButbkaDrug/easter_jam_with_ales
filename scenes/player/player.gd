extends Node2D

@export var bullet_scene: PackedScene

@onready var _tower: AnimatedSprite2D = $Tower
@onready var _animation_player: AnimationPlayer = $AnimationPlayer
@onready var _range: Area2D = $Range
@onready var _muzzle: Marker2D = $Muzzle
@onready var _timer: Timer = $Timer

var hp:int = 1000
var active: bool = true
var fire_rate: float = .5
var targets: Array[Node2D]
var current_target: Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_tower.play("idle")
	_animation_player.play("idle")
	_timer.wait_time = fire_rate

func is_dead() -> bool:
	return hp <= 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	# Play death animation
	if is_dead() && _tower.animation != "death":
		_tower.play("death")

	if !active:
		return

	_select_target()

	if current_target:
		# we shoot this bad boy
		if _animation_player.current_animation == "idle":
			_animation_player.play("preattack")

		fire(current_target.global_position)
		pass
	else:
		_animation_player.play("idle")
	


func _on_tower_animation_finished() -> void:
	if _tower.animation == "death":
		pass

# Select the target from the target list and assignes it to current_target
# if there is no targets in the list returns null
func _select_target() -> void: 
	if targets.size() == 0:
		return 

	if current_target && current_target.is_dead():
			print("current target is dead", current_target)
			targets.erase(current_target)

	# remove deleted targets 
	targets = targets.filter(func(t): return is_instance_valid(t))
	
	# if there is targets in the list grab the first one
	# otherwise return null
	if targets.size() > 0:
		current_target = targets[0]
	else:
		current_target = null


func _on_range_body_entered(body: Node2D) -> void:
	targets.append(body)
	pass # Replace with function body.


func _on_range_body_exited(body: Node2D) -> void:
	targets.erase(body)
	pass # Replace with function body.

func _instantiate_bullet(target_position: Vector2) -> void:
		if bullet_scene == null:
			printerr("bullet_scene not set in player")
			return

		var b: Node2D = bullet_scene.instantiate()
		b.global_position = _muzzle.global_position
		b.direction = (target_position - b.global_position).normalized()
		b.look_at(target_position)

		get_tree().current_scene.add_child(b)

func fire(target_position: Vector2) -> void:
	if _timer.is_stopped():
		_instantiate_bullet(target_position)
		_timer.start()

func take_damage(damage: int) -> void:
	hp -= damage
	if hp <=0:
		hp = 0
		active = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"preattack":
			_animation_player.play("attack")
		"attack":
			if targets.size() < 1:
				_animation_player.play("idle")
