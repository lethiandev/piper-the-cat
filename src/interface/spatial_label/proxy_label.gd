extends Label

export var bounds_margin = Vector2(10, 10)

func _process(p_delta: float) -> void:
	rect_pivot_offset = rect_size / 2
	_keep_on_screen()

func _keep_on_screen() -> void:
	var bounds = get_viewport_rect().size - rect_size - bounds_margin
	rect_position.x = clamp(rect_position.x, bounds_margin.x, bounds.x)
	rect_position.y = clamp(rect_position.y, bounds_margin.y, bounds.y)
