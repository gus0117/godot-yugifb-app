extends VBoxContainer

class_name CardInfo

@onready var card_fusion_info: Label = $CardFusionInfo
@onready var result_card_info: Label = $ResultCardInfo


func show_card(cfi: String = "No card", result: String = "No result", color: Color = Color.WHITE)->void:
	print(color)
	card_fusion_info.text = cfi
	#card_fusion_info.label_settings.font_color = color
	card_fusion_info.add_theme_color_override("font_color", color)
	result_card_info.text = result
	#result_card_info.label_settings.font_color = color
	result_card_info.add_theme_color_override("font_color", color)

func remove_this_card() -> void:
	queue_free()
