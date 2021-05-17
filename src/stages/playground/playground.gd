extends Node

func _ready() -> void:
	var round_time = 1.5 * 60.0
	GameState.connect("game_ready", self, "_on_game_ready")
	GameState.connect("game_ended", self, "_on_game_ended")
	GameState.game_start(round_time)
	get_tree().set_pause(true)
	Transition.fade_in()

func _on_game_ready() -> void:
	get_tree().set_pause(false)
	$AudioStreamPlayer.play()

func _on_game_ended() -> void:
	get_tree().set_pause(true)
	$AudioStreamPlayer.stop()
	yield(get_tree().create_timer(1.0), "timeout")
	Transition.fade_out()
