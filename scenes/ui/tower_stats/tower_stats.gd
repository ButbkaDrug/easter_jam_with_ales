extends Control

@onready var _level: Label = %LevelValue
@onready var _health: Label = %HealthValue


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_level(value: int) -> void:
	_level.text = str(value)

func set_health(value: int) -> void:
	_health.text = str(value)


func _on_texture_button_pressed() -> void:
	visible = false
