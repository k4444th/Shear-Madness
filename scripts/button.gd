extends TextureButton

@onready var text = $Text

func _on_mouse_entered() -> void:
	text.position.y = 5

func _on_mouse_exited() -> void:
	text.position.y = 8
