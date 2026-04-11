extends Node2D

@onready var _tower: AnimatedSprite2D = $Tower
@onready var _archer: AnimatedSprite2D = $Archer

@onready var _collision_shape_2d: CollisionShape2D = $CollisionShape2D

var hp:int = 100
var targets: Array[Node2D]
var current_target: Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_tower.play("idle")
	_archer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	_select_target()

	if current_target:
		# we shoot this bad boy
		pass
	
	if hp <= 0 && _tower.animation != "death":
		_tower.play("death")


func _on_tower_animation_finished() -> void:
	if _tower.animation == "death":
		queue_free()

# Add enemy to the target list if in range
func _on_range_area_entered(area: Area2D) -> void:
	print("enemy detected and added to the list")
	targets.append(area)

# Remove enemy from the target list if exited
func _on_range_area_exited(area: Area2D) -> void:
	targets.erase(area)

# Select the target from the target list and assignes it to current_target
# if there is no targets in the list returns null
func _select_target() -> void: 
	if targets.size() == 0:
		return 

	# remove deleted targets 
	targets = targets.filter(func(t): return is_instance_valid(t))
	
	# if there is targets in the list grab the first one
	# otherwise return null
	if targets.size() > 0:
		current_target = targets[0]
	else:
		current_target = null

