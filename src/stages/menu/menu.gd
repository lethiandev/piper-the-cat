extends Node

func _ready():
	$Control/VBoxContainer/Button.connect("pressed", self, "_on_start_pressed")

func _on_start_pressed() -> void:
	get_tree().change_scene("res://stages/playground/playground.tscn")
