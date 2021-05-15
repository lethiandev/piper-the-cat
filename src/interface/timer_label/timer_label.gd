extends Label

export var timer_node: NodePath

func _physics_process(p_delta: float) -> void:
	if has_node(timer_node) and get_node(timer_node) is Timer:
		var timer = get_node(timer_node)
		_update_time_label(timer)
		_update_blinking(timer)

func _update_time_label(p_timer: Timer) -> void:
	var time_left = p_timer.time_left
	var minutes = int(time_left / 60)
	var seconds = int(time_left) % 60 + (time_left - int(time_left))
	var formatted = str(seconds).pad_zeros(2).pad_decimals(2)
	text = "%d:%s" % [minutes, formatted]

func _update_blinking(p_timer: Timer) -> void:
	var time_left = p_timer.time_left
	if time_left < 30 and time_left > 0:
		var switch = int(time_left * 100) % 100 < 50
		modulate = Color.red if switch else Color.white
	else:
		modulate = Color.white
