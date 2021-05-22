extends "./unparent.gd"
tool

func _post_unparent(p_node: Node) -> void:
	._post_unparent(p_node)
	if p_node is MeshInstance:
		_fix_shadowcast(p_node)

func _fix_shadowcast(p_node: MeshInstance) -> void:
	p_node.cast_shadow = GeometryInstance.SHADOW_CASTING_SETTING_DOUBLE_SIDED
