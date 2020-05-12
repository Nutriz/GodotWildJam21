extends Node

enum Inputs {A1, A2, A3, A4, A5, B1, B2, B3, B4, B5}

var switch_button

var language = "fr"

onready var dials = load_dialogue("res://Assets/Dialogues/dialogues.json.gd")
var introduction
onready var main_story = dials["main_story"]
onready var secondary_stories = dials["secondary_stories"]

func _ready():
	if language == "fr":
		introduction = dials["introduction_fr"]
	else:
		introduction = dials["introduction_en"]

func load_dialogue(file_path):
	var file = File.new()
	assert(file.file_exists(file_path), "file don't exist")

	file.open(file_path, file.READ)
	var dialogues = parse_json(file.get_as_text())
	assert(dialogues.size() > 0, "dialogue is empty")
	return dialogues
