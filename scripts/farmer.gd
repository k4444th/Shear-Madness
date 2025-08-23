extends CharacterBody2D

var speed := 25
var direction: Vector2
var randAngle: float
var destination: Vector2

@onready var timer := $Timer
@onready var sprite := $Sprite

signal touchedLama()

func calculateDirection(destPos: Vector2):
	direction = (destPos - global_position).normalized()
	randAngle = randf_range(-0.3, 0.3)
	direction.rotated(randAngle)

func moveTo(destPos: Vector2):
	destination = destPos
	calculateDirection(destPos)
	
	timer.start()

func updateDest(destPos: Vector2):
	destination = destPos

func _on_timer_timeout() -> void:
	calculateDirection(destination)
	timer.start()

func _physics_process(_delta: float) -> void:
	velocity = direction * speed
	
	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.collision_layer == 2:
		speed = 0
		var tween = get_tree().create_tween()
		if area.global_position < global_position:
			tween.tween_property(sprite, "rotation", 1, 0.1)
		else:
			tween.tween_property(sprite, "rotation", -1, 0.1)
		
		await tween.finished
		queue_free()
		
	elif area.collision_layer == 1:
		touchedLama.emit()
		queue_free()
	
