extends Node

func _ready() -> void:
	var round_time = 3.0 * 60.0
	GameState.connect("game_ready", self, "_on_game_ready")
	GameState.game_start(round_time)
	get_tree().set_pause(true)

func _on_game_ready() -> void:
	get_tree().set_pause(false)
