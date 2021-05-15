extends AudioStreamPlayer

export var wait_time = 0.1
onready var time_left = wait_time

func _process(p_delta: float) -> void:
	time_left = max(0.0, time_left - p_delta)

func play(p_from_position: float = 0.0) -> void:
	if time_left > 0:
		return
	.play(p_from_position)
	time_left = wait_time
