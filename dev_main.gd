extends Node

@onready var enemy_spawner: PathFollow2D = $EnemySpawns/EnemySpawner

@export var slime_scene: PackedScene
@export var player: StaticBody2D

var timer: float = 0
var max_timer: float = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer >= max_timer:
		timer = 0
		var slime = slime_scene.instantiate()
		enemy_spawner.progress_ratio = randf()
		slime.position = enemy_spawner.position
		add_child(slime)
