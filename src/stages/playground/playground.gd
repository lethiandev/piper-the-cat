extends Node

func _ready() -> void:
	var round_time = 2.0 * 60.0
	GameState.connect("game_ready", self, "_on_game_ready")
	GameState.connect("game_ended", self, "_on_game_ended")
	GameState.game_start(round_time)
	#get_tree().set_pause(true)
	Transition.fade_in()

func _on_game_ready() -> void:
	get_tree().set_pause(false)

func _on_game_ended() -> void:
	Transition.fade_out()
