extends Control

export var timer_node: NodePath

func _ready():
	if has_node(timer_node):
		var timer = get_node(timer_node)
		$TimerLabel.timer_node = timer.get_path()
