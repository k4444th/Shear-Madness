extends Node

@onready var camera := $Camera2D

func _ready() -> void:
	camera.zoom = Gamemanger.gameData["settings"]["zoom"]
