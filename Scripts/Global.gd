extends Node

enum Inputs {A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, B1, B2, B3, B4, B5, B6}

var switch_button

var language = "fr"

onready var dials = load_dialogue("res://Assets/Dialogues/dialogues.json.gd")
var introduction
onready var main_story = dials["main_story"]
onready var secondary_stories = dials["secondary_stories"]

func _ready():
	if language == "fr":
		introduction = dials["story_introduction_fr"]
	else:
		introduction = dials["story_introduction_en"]

func load_dialogue(file_path):
	var file = File.new()
	assert(file.file_exists(file_path), "file don't exist")

	file.open(file_path, file.READ)
	var dialogues = parse_json(file.get_as_text())
	assert(dialogues.size() > 0, "dialogue is empty")
	return dialogues

func get_translated_text(msg):
	if language == "fr":
		return msg.text_fr
	else:
		return msg.text_en

func display_debug(debug_text):
		debug_text.text += "***************************************\n"
		debug_text.text += "*             INTRODUCTION            *\n"
		debug_text.text += "***************************************\n"

		for msg in Global.introduction:
			debug_text.text += "\n" + msg

		debug_text.text += "\n\n\n***************************************\n"
		debug_text.text += "*              MAIN STORY             *\n"
		debug_text.text += "***************************************\n"
		debug(main_story, debug_text)

		debug_text.text += "\n\n***************************************\n"
		debug_text.text += "*          SECONDARIES STORY          *\n"
		debug_text.text += "***************************************\n"
		debug(secondary_stories, debug_text)

func debug(story, debug_text):
	for dial in story:
		debug_text.text += "\n---------- " + dial + " ----------"
		var curr_dial = story[dial]
		for msg_index in curr_dial.size():
			if msg_index < curr_dial.size() - 1:
				debug_text.text += "\n" + curr_dial[msg_index].name + ": " + Global.get_translated_text(curr_dial[msg_index])
			else:
				for b in curr_dial[msg_index]:
					debug_text.text += "\n" + b
					for answer_index in curr_dial[msg_index][b].size():
						if curr_dial[msg_index][b][answer_index].pos == "called":
							debug_text.text += "\n\t" + curr_dial[msg_index][b][answer_index].name + ": " + Global.get_translated_text(curr_dial[msg_index][b][answer_index])
						else:
							debug_text.text += "\n\t" + curr_dial[msg_index][b][answer_index].name + ": " + Global.get_translated_text(curr_dial[msg_index][b][answer_index])
		debug_text.text += "\n"
