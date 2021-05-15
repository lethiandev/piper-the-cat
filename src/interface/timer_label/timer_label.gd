extends Label

export var timer_node: NodePath

func _physics_process(p_delta: float) -> void:
	if has_node(timer_node) and get_node(timer_node) is Timer:
		_update_time_label(get_node(timer_node))

func _update_time_label(p_timer: Timer) -> void:
	var time_left = p_timer.time_left
	var minutes = int(time_left / 60)
	var seconds = int(time_left) % 60 + (time_left - int(time_left))
	var formatted = str(seconds).pad_zeros(2).pad_decimals(2)
	text = "%d:%s" % [minutes, formatted]
