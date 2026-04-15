extends Control

@onready var score_label: Label = %ScoreLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameData.score_updated.connect(_on_score_update)
	 
func _on_score_update(new_score: int):
	score_label.text = str(new_score)


func _on_check_button_toggled(toggled_on: bool) -> void:
	SettingsManager.toggle_audio("SFX", toggled_on)
