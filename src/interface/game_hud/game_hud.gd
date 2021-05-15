extends Control

func _ready() -> void:
	GameState.connect("game_started", self, "_on_game_started")
	GameState.connect("game_ready", self, "_on_game_ready")
	GameState.connect("game_ended", self, "_on_game_ended")
	GameState.connect("score_changed", self, "_on_score_changed")
	
	$HideTimer.connect("timeout", $ReadyLabel, "set_visible", [false])
	
	$ReadyLabel.timer_node = "/root/GameState/ReadyTimer"
	$TimerLabel.timer_node = "/root/GameState/GameTimer"

func _on_game_started() -> void:
	_on_score_changed()

func _on_game_ready() -> void:
	$HideTimer.start()

func _on_game_ended() -> void:
	pass

func _on_score_changed() -> void:
	var score = GameState.get_score()
	$Score.text = str(score)
