extends Node

const SAVE_FILE_PATH := "user://shear-madness.json"

var gameData := {
	"highscore": 0,
	"settings": {
		"zoom": Vector2(7.5, 7.5)
	}
}

func _ready() -> void:
	loadGame()

func saveGame():
	var data = {
		"gameData": gameData
	}
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()

func loadGame():
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		var content = file.get_as_text()
		file.close()

		var loadedData = JSON.parse_string(content)
		if typeof(loadedData) == TYPE_DICTIONARY:
			gameData = loadedData.get("gameData", {
				"highscore": 0,
				"settings": {
					"zoom": Vector2(7.7, 7.5)
				}
			})

func resetGame():
	gameData["highscore"] = 0
	gameData["settings"].zoom = Vector2(7.7, 7.5)
	saveGame()
