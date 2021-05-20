extends RigidBody
class_name ItemBase

signal item_touched()

export var touch_score: int = 50
export var touch_scene: PackedScene

var touched: bool = false


func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(p_body: PhysicsBody) -> void:
	# Touches other items on collision
	if touched and p_body is get_script():
		p_body.touch()


func touch() -> void:
	if not touched:
		touched = true
		_handle_touch()
		emit_signal("item_touched")

func _handle_touch() -> void:
	_spawn_sibling_node(touch_scene)
	mode = RigidBody.MODE_RIGID


func _spawn_sibling_node(p_scene: PackedScene) -> void:
	if is_inside_tree() and p_scene:
		var sibling = p_scene.instance()
		sibling.transform = transform
		get_parent().add_child_below_node(self, sibling)
