extends Spatial

export var offset = Vector2()

export var text: String = "" \
	setget set_text, get_text

export var modulate: Color = Color.white \
	setget set_modulate, get_modulate

func _process(p_delta: float) -> void:
	var camera = get_viewport().get_camera()
	var origin = get_global_transform().origin
	var unprojected = camera.unproject_position(origin)
	
	if camera.is_position_behind(origin):
		unprojected = unprojected.normalized() * Vector2(-1.0, 1.0)
		unprojected *= get_viewport().get_size().length()
	
	_set_label_position(unprojected)

func _set_label_position(p_position: Vector2) -> void:
	var result_offset = $ProxyLabel.rect_size * 0.5 - offset
	$ProxyLabel.rect_position = p_position - result_offset

func set_text(p_text: String) -> void:
	$ProxyLabel.text = p_text

func get_text() -> String:
	return $ProxyLabel.text

func set_modulate(p_modulate: Color) -> void:
	$ProxyLabel.modulate = p_modulate

func get_modulate() -> Color:
	return $ProxyLabel.modulate
