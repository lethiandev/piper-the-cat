extends Node

func _ready():
	get_tree().set_pause(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Control/VBoxContainer/Button.connect("pressed", self,
		"_on_start_pressed", [], CONNECT_ONESHOT)
	Transition.fade_in()

func _on_start_pressed() -> void:
	yield(Transition.fade_out(), "completed")
	get_tree().change_scene("res://stages/playground/playground.tscn")
