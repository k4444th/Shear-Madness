extends Sprite2D

@onready var woolmeter := $"."

func updateWool(wool: int):
	var woolElements = woolmeter.get_children()
	for element in woolElements:
		if int(str(element.name)[4]) <= wool:
			element.visible = true
		else:
			var tween = get_tree().create_tween()
			tween.tween_property(element, "scale:x", 0, 0.25)
			await tween.finished
			element.visible = false
