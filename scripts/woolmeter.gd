extends Sprite2D

var wool = 0

@onready var woolmeter := $"."

func _ready():
	var woolElements = woolmeter.get_children()
	for element in woolElements:
		if int(str(element.name)[4]) <= wool:
			element.visible = true
		else:
			element.visible = false
