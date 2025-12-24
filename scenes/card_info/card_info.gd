extends VBoxContainer

class_name CardInfo

@onready var card_fusion_info: Label = $CardFusionInfo
@onready var result_card_info: Label = $ResultCardInfo

func show_card(cfi: String, result: String)->void:
	print(cfi)
	print(result)

func remove_this_card() -> void:
	queue_free()
