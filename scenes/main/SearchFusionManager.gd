extends Control
class_name SearchFusionManager

const CARD_INFO = preload("uid://ccs2a5iwlnahc")
const FUSION_CONTAINER = preload("uid://c43t2moi1d3jj")

const CARDS_URL: String = "res://database/cards.json"
const FUSIONS_URL: String = "res://database/fusions.json"

const TEXT_COLORS: Array = [Color.CORAL, Color.AQUAMARINE, Color.DEEP_PINK, Color.MOCCASIN]

@onready var card_input: LineEdit = $MarginContainer/VBoxContainer/SearchComponent/LineEdit
@onready var subtitle: Label = $MarginContainer/VBoxContainer/Subtitle
@onready var card_founded: CardInfo = $MarginContainer/VBoxContainer/CardFounded
@onready var card_list: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainerFusions/CardList
@onready var card_list_founded: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainerFoundCards/CardList
@onready var scroll_container_fusions: ScrollContainer = $MarginContainer/VBoxContainer/ScrollContainerFusions
@onready var scroll_container_found_cards: ScrollContainer = $MarginContainer/VBoxContainer/ScrollContainerFoundCards
@onready var fusion_title: Label = $MarginContainer/VBoxContainer/FusionTitle
@onready var result_title: Label = $MarginContainer/VBoxContainer/ResultTitle

@export var text_only: bool = false

var cards: Array
var fusions: Array
var color_index: int = 0

func _ready() -> void:
	cards = get_data(CARDS_URL)
	fusions = get_data(FUSIONS_URL)
	reset()

func reset() -> void:
	color_index = 0
	card_input.text = ""
	subtitle.text = ""
	# Remover hijos de la lista card_list
	if card_list.get_child_count() > 0:
		for n in card_list.get_children():
			n.queue_free()
	if card_list_founded.get_child_count() > 0:
		for n in card_list_founded.get_children():
			n.queue_free()
	card_founded.visible = false
	scroll_container_fusions.visible = false
	fusion_title.visible = false
	scroll_container_found_cards.visible = false
	result_title.visible = false

# Obtiene de la base de datos las cartas como array
func get_data(url: String) -> Variant:
	if not FileAccess.file_exists(url):
		print("Cant find cards")
		return null
	
	var file: FileAccess = FileAccess.open(url, FileAccess.READ)
	if FileAccess.get_open_error() != OK:
		print("Error opening file")
		return null
	
	var json_text: String = file.get_as_text()
	file.close()
	var parse_result = JSON.parse_string(json_text)
	
	if parse_result == null:
		print("Error parse JSON")
		return null
	return parse_result

# Busca una carta por su nombre o numero
func search_card() -> void:
	var search: String = card_input.text
	var result: Dictionary
	var fusion_list: Array
	if search.is_valid_int():
		# Buscar por ID
		result = search_by_number(int(search))
		show_card_info(result)
		# Mostrar fusiones
		fusion_list = get_fusions(int(result["CardID"]))
		add_fusions_to_list(result, fusion_list)
	else:
		# Buscar por nombre
		var results = search_by_name(search)
		if results.size() == 1:
			result = results[0]
			show_card_info(result)
			# Mostrar fusiones
			get_fusions(int(result["CardID"]))
			add_fusions_to_list(result, fusion_list)
		else:
			show_results(results)

func show_results(r: Array)->void:
	scroll_container_fusions.visible = false
	fusion_title.visible = false
	scroll_container_found_cards.visible = true
	result_title.visible = true
	for c in r:
		var card_info: CardInfo = CARD_INFO.instantiate()
		card_list_founded.add_child(card_info)
		card_info.set_card(c)

func search_by_number(id: int) -> Dictionary:
	var result: Dictionary = {}
	for c in cards:
		if id == c["CardID"]:
			result = c
			break
	return result

func search_by_name(nameCard: String) -> Array:
	var results: Array = []
	for c in cards:
		var auxName: String = c["CardName"]
		if auxName.to_upper().contains(nameCard.to_upper()):
			results.append(c)
	return results

# Obtiene las fusiones disponibles para la carta encontrada
func get_fusions(cardId: int) -> Array:
	var fusion_list: Array = []
	for c in fusions:
		if cardId == int(c["Material1"]):
			fusion_list.append(c)
	return fusion_list

# Agrega las fusiones disponibles al contenedor
func add_fusions_to_list(material_1: Dictionary, fusionList: Array) -> void:
	scroll_container_fusions.visible = true
	fusion_title.visible = true
	scroll_container_found_cards.visible = false
	result_title.visible = false
	var i:int = 1
	for c in fusionList:
		var fusion_container: FusionContainer = FUSION_CONTAINER.instantiate()
		card_list.add_child(fusion_container)
		var material_2: Dictionary = search_by_number(c["Material2"])
		var result: Dictionary = search_by_number(c["Result"])
		
		fusion_container.set_fusion(i, material_1, material_2, result, get_text_color())
		i += 1


# Muestra la información de la carta encontrada
func show_card_info(card: Dictionary) -> void:
	if card.is_empty():
		subtitle.text = "Card not found"
		return
	subtitle.text = "Founded Card"
	card_founded.set_card(card)
	card_founded.visible = true

func get_card_as_string(card: Dictionary) -> String:
	var card_as_str: String
	var card_id:String = str(int(card["CardID"]))
	var card_name:String = card["CardName"]
	var card_type:String = card["CardType"]
	var card_atk:String = str(int(card["Attack"]))
	var card_def:String = str(int(card["Defense"]))
	var card_pass:String = str(int(card["Password"]))
	
	card_as_str = "#"+card_id+" "+card_name+" "+card_type +" "+card_atk+"/"+card_def+" "+card_pass
	return card_as_str

func get_text_color() -> Color:
	var c: Color = TEXT_COLORS[color_index]
	color_index += 1
	if color_index >= TEXT_COLORS.size():
		color_index = 0
	return c

# Ejecuta la busqueda de una carta
func on_btn_search() -> void:
	var aux_text = card_input.text
	reset()
	card_input.text = aux_text
	search_card()

# Ejecuta la limpieza del input y del contenedor de cartas
func on_btn_clear() -> void:
	reset()
