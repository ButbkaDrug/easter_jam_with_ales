extends Node

@onready var enemy_spawner: PathFollow2D = $EnemySpawns/EnemySpawner

@export var slime_scene: PackedScene
@export var player: StaticBody2D

@onready var _container: VBoxContainer = $HUD/Control/VBoxContainer

var _enemy_count: Label = Label.new()
var _fps: Label = Label.new()

var timer: float = 0
var max_timer: float = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_container.add_child(_enemy_count)
	_container.add_child(_fps)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer >= max_timer:
		timer = 0
		var slime = slime_scene.instantiate()
		enemy_spawner.progress_ratio = randf()
		slime.position = enemy_spawner.position
		slime.add_to_group("Enemies")
		add_child(slime)

	var count:int = get_tree().get_node_count_in_group("Enemies")
	var fps: int = Engine.get_frames_per_second()
	_enemy_count.text ="enemies in the group {0}".format([count])
	_fps.text = "FPS: {0}".format([fps])
