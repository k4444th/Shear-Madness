extends Node

var speed := 10.0
var count := 3
var targetPos: Vector2

@onready var lama := $Lama
@onready var timer := $Timer
@onready var countdown := $Countdown
@onready var camera := $Lama/Camera2D
@onready var background := $Background
@onready var hud := $CanvasLayer
@onready var woolmeter := $CanvasLayer/Woolmeter
@onready var countdownDisplay := $CountdownDisplay

@onready var spitScene := preload("res://scenes/spit.tscn")
@onready var farmerScene := preload("res://scenes/farmer.tscn")

func _ready() -> void:
	hud.scale = Gamemanger.gameData["settings"]["zoom"]
	positionWoolmeter()
	woolmeter.updateWool(9)
	camera.zoom = Gamemanger.gameData["settings"]["zoom"]
	lama.connect("woolLevelChnaged", Callable(self, "updateWool"))
	countdownDisplay.text = str(3)
	countdownDisplay.global_position = lama.global_position - Vector2(countdownDisplay.size.x / 2, countdownDisplay.size.y)
	countdownDisplay.visible = true
	countdownDisplay.set_pivot_offset(countdownDisplay.size / 2)
	var tween = get_tree().create_tween()
	tween.tween_property(countdownDisplay, "scale", Vector2(2, 2), 1)
	countdown.start()

func _input(event):
	if event is InputEventMouseButton and event.pressed == true and lama.direction == Vector2.ZERO:
		var spitInstance = spitScene.instantiate()
		add_child(spitInstance)
		spitInstance.global_position = lama.global_position
		spitInstance.launch(lama.get_global_mouse_position())

func positionWoolmeter():
	pass

func spawnFarmer():
	var spawnPos = Vector2()
	var inverse = camera.get_canvas_transform().affine_inverse()
	var posValid = false
	
	while !posValid:
		var side = randi() % 4
		match side:
			0:
				spawnPos.x = randf_range(inverse.origin.x, camera.get_viewport().size.x / camera.get_canvas_transform().x[0])
				spawnPos.y = inverse.origin.y
			1:
				spawnPos.x = inverse.origin.x
				spawnPos.y = randf_range(inverse.origin.y, camera.get_viewport().size.y / camera.get_canvas_transform().x[0])
			2:
				spawnPos.x = randf_range(inverse.origin.x, camera.get_viewport().size.x / camera.get_canvas_transform().x[0])
				spawnPos.y = camera.get_viewport().size.y / camera.get_canvas_transform().y[0]
			3:
				spawnPos.x = camera.get_viewport().size.x / camera.get_canvas_transform().x[0]
				spawnPos.y =	 randf_range(inverse.origin.y, camera.get_viewport().size.y / camera.get_canvas_transform().x[0])
		
		if spawnPos.x > background.rectCoords[0].x and spawnPos.x < background.rectCoords[1].x and spawnPos.y > background.rectCoords[0].y and spawnPos.y < background.rectCoords[1].y:
			posValid = true
		
	var farmerInstance = farmerScene.instantiate()
	farmerInstance.global_position = spawnPos
	add_child(farmerInstance)
	lama.connect("posChanged", Callable(farmerInstance, "updateDest"))
	farmerInstance.connect("touchedLama", Callable(lama, "looseWool"))
	farmerInstance.moveTo(lama.global_position)

func updateWool(wool: int):
	woolmeter.updateWool(wool)

func _on_timer_timeout() -> void:
	spawnFarmer()
	
	if timer.wait_time > 0.5:
		timer.wait_time *= 0.975
		
	timer.start()

func _on_countdown_timeout() -> void:
	count -= 1
	countdownDisplay.text = str(count)
	countdownDisplay.set_pivot_offset(countdownDisplay.size / 2)
	if count > 0:
		countdownDisplay.scale = Vector2(1, 1)
		countdown.start()
		var tween = get_tree().create_tween()
		tween.tween_property(countdownDisplay, "scale", Vector2(2, 2), 1)
	else:
		countdownDisplay.visible = false
		timer.start()
		spawnFarmer()
