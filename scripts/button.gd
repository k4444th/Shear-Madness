extends TextureButton

@onready var text = $Text

func _on_mouse_entered() -> void:
	text.position.y = 1

func _on_mouse_exited() -> void:
	text.position.y = 3
