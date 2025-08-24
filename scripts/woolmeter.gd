extends Sprite2D

@onready var woolmeter := $"."

func updateWool(wool: int):
	var woolElements = woolmeter.get_children()
	for element in woolElements:
		if int(str(element.name)[4]) <= wool:
			element.visible = true
		else:
			element.visible = false
