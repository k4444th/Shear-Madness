extends Node

var rectCoords := [
	Vector2(10000, 10000),
	Vector2(-10000, -10000)
]

@onready var fenceLayer = $Fence

func _ready() -> void:
	getBorder()

func getBorder():
	var usedCells = fenceLayer.get_used_cells()

	for cell in usedCells:
		cell = fenceLayer.to_global(fenceLayer.map_to_local(cell))
		
		if cell.x < rectCoords[0].x:
			rectCoords[0].x = cell.x
		if cell.y < rectCoords[0].y:
			rectCoords[0].y = cell.y
		if cell.x > rectCoords[1].x:
			rectCoords[1].x = cell.x
		if cell.y > rectCoords[1].y:
			rectCoords[1].y = cell.y
