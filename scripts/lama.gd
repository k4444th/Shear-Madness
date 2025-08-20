extends CharacterBody2D

var direction := Vector2(0.0, 0.0)

@export var speed := 100

@onready var sprite = $Sprite

func _process(_delta: float) -> void:
	getKeyboardInputs()
	setAnimation()
	moveSprite()

func getKeyboardInputs():
	direction.x = Input.get_axis("Left", "Right")
	direction.y = Input.get_axis("Up", "Down")

func setAnimation():
	if direction.y >= 0:
		sprite.animation = "front"
	else:
		sprite.animation = "back"
	
	if direction.x != 0:
		sprite.animation = "right"
		if direction.x < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		
	
func moveSprite():
	velocity = direction * speed
	move_and_slide()
