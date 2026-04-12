extends Node2D

@onready var _tower: AnimatedSprite2D = $Tower
@onready var _archer: AnimatedSprite2D = $Archer

var hp:int = 1000
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
