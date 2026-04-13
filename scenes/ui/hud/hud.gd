extends Control

@onready var score_label: Label = $HBoxContainer/ScoreLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameData.score_updated.connect(_on_score_update)
	 
func _on_score_update(new_score: int):
	print("HUD got score update")
	score_label.text = str(new_score)
