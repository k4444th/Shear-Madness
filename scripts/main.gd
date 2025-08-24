extends Node

var speed := 10.0
var targetPos: Vector2

@onready var lama := $Lama
@onready var timer := $Timer
@onready var camera := $Camera2D

@onready var spitScene := preload("res://scenes/spit.tscn")
@onready var farmerScene := preload("res://scenes/farmer.tscn")

func _ready() -> void:
	timer.start()
	spawnFarmer()

func _input(event):
	if event is InputEventMouseButton and event.pressed == true and lama.direction == Vector2.ZERO:
		var spitInstance = spitScene.instantiate()
		add_child(spitInstance)
		spitInstance.global_position = lama.global_position
		spitInstance.launch(lama.get_global_mouse_position())

func spawnFarmer():
	var side = randi() % 4
	var spawnPos = Vector2()
	var inverse = camera.get_canvas_transform().affine_inverse()

	match side:
		0:
			spawnPos.x = randf_range(inverse.origin.x, camera.get_viewport().size.x / camera.get_canvas_transform().x[0])
			spawnPos.y = inverse.origin.y
		1:
			spawnPos.x = inverse.origin.x
			spawnPos.y = randf_range(inverse.origin.y, camera.get_viewport().size.y / camera.get_canvas_transform().x[0])
		2:
			spawnPos.x = randf_range(inverse.origin.x, camera.get_viewport().size.x / camera.get_canvas_transform().x[0])
			spawnPos.y = camera.get_viewport().size.y / camera.get_canvas_transform().x[0]
		3:
			spawnPos.x = camera.get_viewport().size.x / camera.get_canvas_transform().x[0]
			spawnPos.y = randf_range(inverse.origin.y, camera.get_viewport().size.y / camera.get_canvas_transform().x[0])
	
	var farmerInstance = farmerScene.instantiate()
	farmerInstance.global_position = spawnPos
	add_child(farmerInstance)
	lama.connect("posChanged", Callable(farmerInstance, "updateDest"))
	farmerInstance.connect("touchedLama", Callable(lama, "looseWool"))
	farmerInstance.moveTo(lama.global_position)

func _on_timer_timeout() -> void:
	spawnFarmer()
	timer.start()
	
