extends Node2D

@onready var _progress_bar: TextureProgressBar = $TextureProgressBar

func update(current_health: int, max_health: int) -> void:
	var percent:int = (float(current_health) / max_health) * 100

	var t: Tween = get_tree().create_tween()
	t.tween_property(_progress_bar, "value", percent, 0.2).set_trans(Tween.TRANS_SINE)

	visible = percent < 100
