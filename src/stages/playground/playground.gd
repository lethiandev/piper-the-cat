extends Node

func _ready() -> void:
	var round_time = 3.0 * 60.0
	GameState.game_start(round_time)
