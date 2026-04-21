extends Node

@onready var _container: VBoxContainer = $HUD/Control/VBoxContainer
@onready var enemy_spawner: PathFollow2D = $EnemySpawns/EnemySpawner
@onready var _enemy_spawn_timer: Timer = $EnemySpawnTimer

@export var slime_scene: PackedScene
@export var damage_scene: PackedScene
@export var player: StaticBody2D


var _enemy_count: Label = Label.new()
var _fps: Label = Label.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("dev_main ready")
	_container.add_child(_enemy_count)
	_container.add_child(_fps)

	_enemy_spawn_timer.wait_time = 3
	_enemy_spawn_timer.start()

	GameData.enemy_hit.connect(_on_enemy_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	# For TESTING
	var count:int = get_tree().get_node_count_in_group("Enemies")
	var fps: int = Engine.get_frames_per_second()
	_enemy_count.text ="enemies in the group {0}".format([count])
	_fps.text = "FPS: {0}".format([fps])

func spawn_the_mob(mob_scene:PackedScene, spawn_position:Vector2) -> void:
		var mob = mob_scene.instantiate()

		mob.global_position = spawn_position
		mob.add_to_group("Enemies")
		mob.defeated.connect(GameData._on_mob_defeated)
		add_child(mob)


func _on_enemy_spawn_timer_timeout() -> void:
	enemy_spawner.progress_ratio = randf()
	spawn_the_mob(slime_scene, enemy_spawner.global_position)
	pass # Replace with function body.

func _on_enemy_hit(damage:int, position: Vector2):
	var damage_label = damage_scene.instantiate()
	add_child(damage_label)
	damage_label.display(damage, position)
