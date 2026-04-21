extends Node2D

var level: int = 0 
var damage: int = 0
var exp: int = 0
var next_level: int = 0
var upgrading:bool = false


@export var levelsData: Array[TowerLevelData]

@onready var _anim_tree:AnimationTree = $AnimationTree


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("tower enters the world! Let's upgrade to the level 1. I'm calling upgrade func")
	upgrade()
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func upgrade() -> void:
	if level == levelsData.size():
		return

	level += 1

	var param_value:float = float(level)/10
	print("upgrade: setting blend to %f" % param_value)
	_anim_tree["parameters/Idle/blend_position"] = param_value
	_anim_tree["parameters/Upgrade/blend_position"] = param_value

	upgrading = true

func _on_upgrade_timer_timeout() -> void:
	upgrade()

func apply_level() -> void:
	var data:TowerLevelData = levelsData[level-1]
	damage = data.damage
	next_level = data.next_level


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	print("animation finished playing %s" % anim_name)
	if anim_name.begins_with("Upgrade"):
		upgrading = false
		apply_level()
