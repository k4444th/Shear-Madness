extends Node

@onready var camera = $Camera2D
@onready var logo = $CanvasLayer/Logo

func _process(delta: float) -> void:
	var zoom = (float(get_viewport().size.x) / 500 + float(get_viewport().size.y) / 300) / 2
	camera.zoom = Vector2(zoom, zoom)
	
	logo.scale = Vector2(zoom * 2, zoom * 2)
	logo.get_children()[0].size.x = (camera.get_viewport().size.x / camera.get_canvas_transform().x[0]) / 2
	logo.get_children()[1].size.x = (camera.get_viewport().size.x / camera.get_canvas_transform().x[0]) / 2
	logo.position.y = 30 + zoom * 5

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_settings_button_pressed() -> void:
	print("Open Settings")

func _on_story_button_pressed() -> void:
	print("Open Story")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
