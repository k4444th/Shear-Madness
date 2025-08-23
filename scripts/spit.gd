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

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.collision_layer == 4:
		speed = 0
		sprite.play("explode")

func _on_sprite_animation_finished() -> void:
	if sprite.animation == "explode":
		queue_free()
