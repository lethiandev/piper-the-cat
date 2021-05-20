extends ItemBase
class_name ItemShatterable

signal item_shattered()

export var shatter_force: int = 20
export var shatter_score: int = 100
export var shatter_scene: PackedScene

var shattered: bool = false


func _integrate_forces(p_state: PhysicsDirectBodyState) -> void:
	# TODO: Add items shattering feature
	if shattered or shatter_force == 0:
		return


func shatter() -> void:
	if not shattered:
		shattered = true
		_handle_shatter()
		emit_signal("item_shattered")

func _handle_shatter() -> void:
	_spawn_sibling_node(shatter_scene)
	queue_free()
