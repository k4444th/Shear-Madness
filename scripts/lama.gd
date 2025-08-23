extends CharacterBody2D

var wool := 10
var direction := Vector2(0.0, 0.0)
var lastDirection := direction

var initialSpeed := 25.0
var maxSpeed := 75
var speed := initialSpeed

@onready var sprite := $Sprite

signal posChanged(position: Vector2)

func _process(_delta: float) -> void:
	getKeyboardInputs()
	setAnimation()
	moveSprite()
	
	if direction == Vector2.ZERO:
		speed *= 0.9
		if speed < initialSpeed:
			speed = 0
		velocity = lastDirection * speed
		move_and_slide()
	
	if Input.is_action_just_pressed("Up") or Input.is_action_just_pressed("Down") or Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		speed = initialSpeed
		lastDirection = direction

func getKeyboardInputs():
	direction.x = Input.get_axis("Left", "Right")
	direction.y = Input.get_axis("Up", "Down")
	direction = direction.normalized()
	posChanged.emit(global_position)

func setAnimation():
	if direction.y >= 0:
		sprite.animation = "front"
	else:
		sprite.animation = "back"
	
	if direction.x != 0:
		sprite.animation = "side"
		if direction.x > 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		
func moveSprite():
	velocity = direction * speed
	move_and_slide()
	if speed < maxSpeed:
			speed *= 1.025

func looseWool():
	wool -= 1
	print(wool, " wool left")
