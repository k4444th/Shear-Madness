extends CharacterBody2D

var spitTargetPos: Vector2
var speed = 100

@onready var sprite := $Sprite
			
func _physics_process(_delta: float) -> void:
	var direction = spitTargetPos - global_position
	if direction.length() > 5:
		move_and_slide()
		velocity = (spitTargetPos - global_position).normalized() * speed
		if speed < 500:
			speed *= 1.05
	else:
		queue_free()

func launch(targetPos: Vector2) -> void:
	spitTargetPos = targetPos
	visible = true
	sprite.play("default")
	velocity = (targetPos - global_position).normalized() * speed
	rotation = velocity.angle() + 205
