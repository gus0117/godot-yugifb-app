extends Control

class_name CardImageManager

const ROW: int = 29
const COL: int = 25

@onready var card_sheet: Sprite2D = $CardSheet

func set_card_by_id(id: int) -> void:
	if(id > 722):
		return
	var col_index = COL * ((float(id-1)/COL)-((floor(id-1))/COL))
	var row_index = floor(float(id-1)/COL)
	
	var x = int(3 + 107 * col_index)
	var y = int(3 + 101 * row_index)
	card_sheet.region_rect.position = Vector2(x, y)
