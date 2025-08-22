extends Node

var speed := 10.0
var targetPos: Vector2

@onready var lama := $Lama
@onready var spitScene := preload("res://scenes/spit.tscn")


func _input(event):
	if event is InputEventMouseButton and event.pressed == true:
		var spitInstance = spitScene.instantiate()
		add_child(spitInstance)
		spitInstance.global_position = lama.global_position
		spitInstance.launch(lama.get_global_mouse_position())
