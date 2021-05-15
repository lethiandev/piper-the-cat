extends Spatial

func _physics_process(p_delta: float) -> void:
	var camera = get_viewport().get_camera()
	var camera_basis = camera.global_transform.basis
	global_transform.basis = camera_basis
