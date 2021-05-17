extends RigidBody

signal item_moved()

export var move_score: int = 50

var has_moved = false
var start_position = Vector3()

func _ready() -> void:
	start_position = global_transform.origin

func _integrate_forces(p_state: PhysicsDirectBodyState) -> void:
	var origin = p_state.transform.origin
	if start_position.distance_squared_to(origin) > 0.01:
		_handle_item_moved()

func _handle_item_moved() -> void:
	if has_moved:
		return
	emit_signal("item_moved")
	has_moved = true
