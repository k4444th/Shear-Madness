extends Node

@onready var camera = $Camera2D

func _process(delta: float) -> void:
	var zoom = (get_viewport().size.x / 500 + get_viewport().size.y / 300) / 2
	camera.zoom = Vector2(zoom, zoom)
	

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_settings_button_pressed() -> void:
	print("Open Settings")

func _on_story_button_pressed() -> void:
	print("Open Story")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
