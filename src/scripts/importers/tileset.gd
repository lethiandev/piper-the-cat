extends EditorScenePostImport
tool

func post_import(p_scene: Object) -> Object:
	if p_scene is Node:
		return _unparent(p_scene)
	return p_scene

func _unparent(p_node: Node) -> Node:
	var new_root = p_node.get_child(0)
	new_root.name = p_node.name
	_untransform(new_root)
	_shadowcast(new_root)
	return new_root

func _untransform(p_node: Node) -> void:
	if p_node is Spatial:
		p_node.transform.origin = Vector3()
		p_node.transform.basis = Basis()

func _shadowcast(p_node: Node) -> void:
	if p_node is MeshInstance:
		var mode = GeometryInstance.SHADOW_CASTING_SETTING_DOUBLE_SIDED
		p_node.cast_shadow = mode
