extends RigidBody

signal item_moved()

export var move_score: int = 10

var has_moved = false

func _integrate_forces(p_state: PhysicsDirectBodyState) -> void:
	if p_state.linear_velocity.length_squared() > 1.0:
		_handle_item_moved()

func _handle_item_moved() -> void:
	if has_moved:
		return
	emit_signal("item_moved")
	has_moved = true
