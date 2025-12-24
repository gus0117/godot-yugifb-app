extends Control
class_name SearchFusionManager

const CARD_INFO = preload("uid://ccs2a5iwlnahc")
const CARDS_URL: String = "res://database/cards.json"
const FUSIONS_URL: String = "res://database/fusions.json"

@onready var card_input: LineEdit = $MarginContainer/VBoxContainer/SearchComponent/LineEdit
@onready var card_founded: Label = $MarginContainer/VBoxContainer/CardFounded
@onready var card_list: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainer/CardList

var cards: Array


func _ready() -> void:
	get_cards()
	get_fusions()
	reset()

func reset() -> void:
	card_input.text = ""
	card_founded.text = ""
	# Remover hijos de la lista card_list
	if card_list.get_child_count() > 0:
		for n in card_list.get_children():
			n.remove_this_card()

# Obtiene de la base de datos las cartas
func get_cards() -> void:
	if not FileAccess.file_exists(CARDS_URL):
		print("Cant find cards")
		return
	
	var file: FileAccess = FileAccess.open(CARDS_URL, FileAccess.READ)
	if FileAccess.get_open_error() != OK:
		print("Error opening file")
		return
	
	var json_text: String = file.get_as_text()
	file.close()
	var parse_result = JSON.parse_string(json_text)
	

# Obtiene de la base de datos las fusiones
func get_fusions() -> void:
	if not FileAccess.file_exists(FUSIONS_URL):
		print("Cant find fusions")
		return

# Busca una carta por su nombre o numero
func search_card() -> void:
	pass

# Busca las fusiones disponibles para la carta encontrada
func search_fusions() -> void:
	pass

# Agrega las fusiones disponibles al contenedor
func add_fusions_to_list() -> void:
	pass

# Muestra la información de la carta encontrada
func show_card_info() -> void:
	pass

# Ejecuta la busqueda de una carta
func on_btn_search() -> void:
	pass

# Ejecuta la limpieza del input y del contenedor de cartas
func on_btn_clear() -> void:
	pass
