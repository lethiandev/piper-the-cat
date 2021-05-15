extends Node

signal game_started()
signal game_ready()
signal game_ended()

signal score_changed()

var score: int = 0

func _ready() -> void:
	$ReadyTimer.connect("timeout", $GameTimer, "start")
	$ReadyTimer.connect("timeout", self, "game_ready")
	$GameTimer.connect("timeout", self, "game_end")

func game_start(p_time: float) -> void:
	$ReadyTimer.start()
	$GameTimer.start(p_time)
	$GameTimer.set_paused(true)
	score = 0
	emit_signal("game_started")

func game_ready() -> void:
	$GameTimer.set_paused(false)
	emit_signal("game_ready")

func game_end() -> void:
	$ReadyTimer.stop()
	$GameTimer.stop()
	emit_signal("game_ended")

func add_score(p_score: int) -> void:
	score += p_score
	emit_signal("score_changed")

func get_score() -> int:
	return score
