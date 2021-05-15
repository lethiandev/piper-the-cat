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
	$GameTimer.stop()
	$GameTimer.wait_time = p_time
	score = 0

func game_ready() -> void:
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
