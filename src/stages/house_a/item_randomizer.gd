extends Spatial

export var item_count: int = 200
export var item_scene: PackedScene

func _ready() -> void:
	randomize()
	for i in range(item_count):
		var item = item_scene.instance()
		var rand = Vector3(randf() - 0.5, randf() * 0.5, randf() - 0.5) * 2.0
		item.transform.origin = Vector3(1, 6, 1) * rand
		add_child(item)
