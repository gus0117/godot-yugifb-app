extends HBoxContainer

class_name FusionContainer

@onready var fusion_id: Label = $FusionId
@onready var material_1: CardInfo = $Material_1
@onready var material_2: CardInfo = $Material_2
@onready var result: CardInfo = $Result
@onready var plus: Label = $Plus
@onready var equal: Label = $Equal


func set_fusion(id: int, m_1: Dictionary, m_2: Dictionary, r: Dictionary, color: Color = Color.WHITE)-> void:
	fusion_id.text = str(id)
	material_1.set_card(m_1)
	material_2.set_card(m_2)
	result.set_card(r)
	
	fusion_id.add_theme_color_override("font_color", color)
	plus.add_theme_color_override("font_color", color)
	equal.add_theme_color_override("font_color", color)
