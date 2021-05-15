extends "res://items/item_base/item_base.gd"

signal item_shattered()

export var shatter_score = 100.0
export var shatter_force = 40.0

onready var previous_velocity = linear_velocity

func _integrate_forces(p_state: PhysicsDirectBodyState) -> void:
	._integrate_forces(p_state)
	
	var lv = p_state.linear_velocity
	
	for index in range(p_state.get_contact_count()):
		var body = p_state.get_contact_collider_object(index)
		if body is StaticBody:
			_handle_collision(lv)
			break
	
	previous_velocity = lv

func _handle_collision(p_lv: Vector3) -> void:
	if p_lv.length_squared() > previous_velocity.length_squared():
		return
	
	var relative = p_lv - previous_velocity
	var force = relative.length_squared()
	if force > shatter_force:
		emit_signal("item_shattered")
		queue_free()
