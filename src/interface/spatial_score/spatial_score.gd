extends "res://interface/spatial_label/spatial_label.gd"

export var scale_from = Vector2(0.4, 0.4)
export var scale_to = Vector2(1.0, 1.0)
export var velocity = Vector2(0.0, -80.0)

func _ready():
	$Tween.interpolate_property($ProxyLabel, NodePath("rect_scale"),
		scale_from, scale_to, 1.0, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.connect("tween_all_completed", self, "queue_free")
	$Tween.start()

func _process(p_delta: float) -> void:
	offset += velocity * p_delta
