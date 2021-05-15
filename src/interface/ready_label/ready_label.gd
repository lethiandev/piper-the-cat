extends Label

export var timer_node: NodePath

func _process(p_delta: float) -> void:
	if has_node(timer_node) and get_node(timer_node) is Timer:
		_update_ready_label(get_node(timer_node))

func _update_ready_label(p_timer: Timer) -> void:
	var time_left = p_timer.time_left
	var ready_frame = p_timer.wait_time - 1.0
	
	if p_timer.is_stopped():
		text = "Go!"
	elif time_left < ready_frame:
		text = "Steady"
	else:
		text = "Ready"
