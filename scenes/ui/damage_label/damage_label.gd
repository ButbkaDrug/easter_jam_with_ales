extends Label

func display(num: int, pos: Vector2) -> void:
	var num_str:String = str(num)


	global_position = pos 
	global_position.y -= size.y
	text = num_str

	var t: Tween = get_tree().create_tween()
	t.set_parallel(true)

	t.tween_property(self, "position:y", position.y - 50, .5)
	t.tween_property(self, "modulate:a", .0, .5)

	t.set_parallel(false)
	t.tween_callback(queue_free)
