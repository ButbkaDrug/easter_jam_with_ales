extends Node

var state = PlayerStats.new()

signal score_updated(new_score: int)

func _on_mob_defeated(points: int) -> void:
	state.score += points

	# Signaling UI that it is time to update
	score_updated.emit(state.score)

