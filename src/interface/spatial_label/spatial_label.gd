extends Spatial

export var offset = Vector2()

export var text: String = "" \
	setget set_text, get_text

func _process(p_delta: float) -> void:
	var camera = get_viewport().get_camera()
	var unprojected = camera.unproject_position(global_transform.origin)
	_set_label_position(unprojected)

func _set_label_position(p_position: Vector2) -> void:
	var result_offset = $ProxyLabel.rect_size * 0.5 - offset
	$ProxyLabel.rect_position = p_position - result_offset

func set_text(p_text: String) -> void:
	$ProxyLabel.text = p_text

func get_text() -> String:
	return $ProxyLabel.text
