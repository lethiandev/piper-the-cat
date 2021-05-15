extends Label

export var follow_node: NodePath
export var follow_origin: Vector3

var offset = Vector2()

func _ready() -> void:
	# Realign label to the center
	rect_pivot_offset = rect_size / 2
	
	# Tween animate scaling
	var scale_from = rect_scale * 0.4
	var scale_to = rect_scale
	$Tween.interpolate_property(self, NodePath("rect_scale"),
		scale_from, scale_to, 1.0, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	$Tween.connect("tween_all_completed", self, "queue_free")
	$Tween.start()

func _process(p_delta: float) -> void:
	offset.y -= 80.0 * p_delta

func _physics_process(p_delta: float) -> void:
	if has_node(follow_node) and get_node(follow_node) is Spatial:
		follow_origin = get_node(follow_node).global_transform.origin
	
	_follow_spatial_origin()
	_keep_on_screen()

func _follow_spatial_origin():
	var camera = get_viewport().get_camera()
	var pos = camera.unproject_position(follow_origin)
	rect_position = pos - rect_size / 2 + offset

func _keep_on_screen() -> void:
	var size = get_viewport_rect().size
	rect_position.x = clamp(rect_position.x, 10.0, size.x - 10 - rect_size.x)
	rect_position.y = clamp(rect_position.y, 10.0, size.y - 10 - rect_size.y)
	
