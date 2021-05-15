extends Node

const ScoreLabelScene = preload("res://interface/score_label/score_label.tscn")
const ShatterEffectScene = preload("res://effects/shatter/shatter.tscn")

func _ready():
	for child in get_children():
		_bind_item_signals(child)

func _bind_item_signals(p_item: Node) -> void:
	if p_item.has_signal("item_moved"):
		p_item.connect("item_moved", self, "_on_item_moved", [p_item])
	if p_item.has_signal("item_shattered"):
		p_item.connect("item_shattered", self, "_on_item_shattered", [p_item])

func _on_item_moved(p_item: Node) -> void:
	var score_label = ScoreLabelScene.instance()
	score_label.text = str(p_item.move_score)
	score_label.follow_origin = p_item.global_transform.origin
	add_child(score_label)

func _on_item_shattered(p_item: Node) -> void:
	var score_label = ScoreLabelScene.instance()
	score_label.text = str(p_item.shatter_score)
	score_label.follow_origin = p_item.global_transform.origin
	score_label.modulate = Color.yellow
	add_child(score_label)
	
	var shatter_node = ShatterEffectScene.instance()
	shatter_node.transform = p_item.transform
	add_child(shatter_node)
