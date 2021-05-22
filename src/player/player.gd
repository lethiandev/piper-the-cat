extends KinematicBody

const GRAVITY = 20
const ACCELERATION = 4.0
const DECELERATION = 6.0
const MAX_SPEED = 5
const JUMP_SPEED = 6
const PUSH = 250

var motion_axis = Vector3()
var motion_velocity = Vector3()

var xspeed = 0.0
var yspeed = 0.0
var air_time = 0.0

var is_walking = false
var is_airborne = false
var is_jumping = false

func _physics_process(p_delta: float) -> void:
	var motion = _get_motion_velocity(p_delta)
	
	# Handle common flags
	is_walking = motion.is_equal_approx(Vector3())
	is_airborne = air_time > (6.0 / 60.0)
	
	# Handle gravity
	if not is_on_floor():
		var factor = 0.5 if is_jumping else 1.0
		yspeed -= GRAVITY * factor * p_delta
		air_time += p_delta
	
	# Handle movement motion
	var gravity = Vector3.UP * yspeed
	var snap = Vector3(0, -0.1, 0) if yspeed <= 0 else Vector3()
	move_and_slide(motion + gravity, Vector3.UP, true, 4, PI/4, false)
	
	# Handle player grounding
	if is_on_floor():
		is_jumping = false
		yspeed = 0
		air_time = 0
	
	if is_on_ceiling() and yspeed > 0:
		is_jumping = false
		yspeed = 0
	
	# Handle jumping
	var grounded = not is_airborne and not is_jumping
	if Input.is_action_pressed("ui_accept") and grounded:
		is_jumping = true
		yspeed = JUMP_SPEED
	
	if Input.is_action_just_released("ui_accept") or yspeed < 0:
		is_jumping = false
	
	# Handle colliding with pushable items
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider is RigidBody:
			var body = collision.collider as RigidBody
			var origin = collision.position - body.global_transform.origin
			if origin.y - 0.2 < 0:
				var target = (-collision.normal + Vector3(0, 0.5, 0)).normalized()
				body.apply_impulse(origin, target * PUSH * p_delta)
	
	# Handle colliding with items
	for index in range(get_slide_count()):
		var coll = get_slide_collision(index)
		var body = coll.collider as RigidBody
		if body and body.is_in_group("items"):
			body.touch()
	
	# Rotate skin
	var angle = Vector2(-motion_axis.x, motion_axis.z).angle()
	var rotated = Basis().rotated(Vector3.UP, angle + PI / 2)
	var old = $PiperSkin.global_transform.basis
	$PiperSkin.global_transform.basis = old.slerp(rotated, 20.0 * p_delta)

func _get_motion_velocity(p_delta: float) -> Vector3:
	var next_motion_axis = _get_motion_axis()
	
	if not next_motion_axis.is_equal_approx(Vector3()):
		xspeed = min(1.0, xspeed + ACCELERATION * p_delta)
		motion_axis = next_motion_axis
	else:
		xspeed = max(0.0, xspeed - DECELERATION * p_delta)
	
	var target = motion_axis * MAX_SPEED
	motion_velocity = lerp(Vector3(), target, xspeed)
	return motion_velocity

func _get_motion_axis() -> Vector3:
	var camera = get_viewport().get_camera()
	var camera_xform = camera.get_global_transform()
	var input_axis = _get_input_axis()
	var motion_axis = Vector3()
	
	motion_axis += camera_xform.basis.x * input_axis.x
	motion_axis += camera_xform.basis.z * input_axis.y
	
	motion_axis.y = 0
	return motion_axis.normalized()

func _get_input_axis() -> Vector2:
	var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	return Vector2(x, z)
