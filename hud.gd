extends CanvasLayer

@onready var _tower_stats_screen: Control = %TowerStats


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameData.tower_selected.connect(_on_tower_selected)
	_tower_stats_screen.visible = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_key_input(event: InputEvent) -> void:
	print("HUD: unhandled key %s" % event.to_string())
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			hide_visible()
			

func _on_tower_selected(tower: Tower) -> void:
	_tower_stats_screen.set_level(tower.level)
	_tower_stats_screen.set_health(tower.hp)
	_tower_stats_screen.visible = true
	pass

func hide_visible() -> void:
	_tower_stats_screen.visible = false
