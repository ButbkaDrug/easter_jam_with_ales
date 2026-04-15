extends Node

func toggle_audio(bus_name: String, value: bool) -> void:
	var index:int = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_mute(index, value)
