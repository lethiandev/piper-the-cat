extends RayCast

var look_axis = Vector2()
var look_target = Vector2()

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	var euler = transform.basis.get_euler()
	look_axis.x = euler.x
	look_axis.y = euler.y
	look_target = look_axis

func _input(p_event: InputEvent) -> void:
	if p_event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if p_event is InputEventMouseMotion:
		var speed = p_event.relative
		look_target.x -= speed.y * 0.005
		look_target.y -= speed.x * 0.005
		look_target.x = clamp(look_target.x, -PI * 0.4, PI * 0.1)

func _physics_process(p_delta: float) -> void:
	look_axis = lerp(look_axis, look_target, 10.0 * p_delta)
	
	var new_basis = Basis()
	new_basis = new_basis.rotated(Vector3.RIGHT, look_axis.x)
	new_basis = new_basis.rotated(Vector3.UP, look_axis.y)
	transform.basis = new_basis
	
	_clip_camera_collision()

func _clip_camera_collision() -> void:
	force_raycast_update()
	
	if is_colliding():
		var point = get_collision_point()
		var relative = global_transform.origin - point
		var distance = relative.length() - 0.5
		_clip_camera(max(0.6, distance))
	else:
		_clip_camera(cast_to.length() - 0.5)

func _clip_camera(p_distance: float) -> void:
	var oldz = $Camera.transform.origin.z
	$Camera.transform.origin.z = lerp(oldz, p_distance, 0.8)
