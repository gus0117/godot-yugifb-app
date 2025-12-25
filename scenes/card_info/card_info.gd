extends HBoxContainer

class_name CardInfo

@onready var card_image: CardImageManager = $CardImage
@onready var card_id_name: Label = $Atributes/CardIDName
@onready var type: Label = $Atributes/Type
@onready var dmg_def: Label = $Atributes/DmgDef
@onready var password: Label = $Atributes/Password

func set_card(card: Dictionary)->void:
	card_image.set_card_by_id(int(card["CardID"]))
	card_id_name.text = "#"+str(int(card["CardID"]))+" "+card["CardName"]
	type.text = card["CardType"]
	dmg_def.text = str(int(card["Attack"]))+"/"+str(int(card["Defense"]))
	password.text = str(int(card["Password"]))

func remove_this_card() -> void:
	queue_free()
