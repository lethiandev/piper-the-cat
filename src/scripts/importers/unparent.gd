extends EditorScenePostImport
tool

func post_import(p_scene: Object) -> Object:
	if p_scene is Node:
		return _unparent(p_scene)
	return p_scene

func _unparent(p_node: Node) -> Node:
	var new_root = p_node.get_child(0)
	new_root.name = p_node.name
	_post_unparent(new_root)
	return new_root

func _post_unparent(p_node: Node) -> void:
	if p_node is Spatial:
		p_node.transform.origin = Vector3()
		p_node.transform.basis = Basis()
