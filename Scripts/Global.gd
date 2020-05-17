extends Node

enum Inputs {A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, B1, B2, B3, B4, B5, B6}

var switch_button

var language = "fr"

var story_index = 0
var henry_annoyed = 0

var end = "introduction"

onready var dials = load_dialogue("res://Assets/Dialogues/dialogues.json")
onready var introduction = dials["story_introduction"]
onready var boss_dialogue = dials["boss_dialogue"]
onready var techman_dialogue = dials["tech_man"]
onready var main_story = dials["main_story"]
onready var secondary_stories = dials["secondary_stories"]
onready var other_dest_people = dials["other_dest_people"]
onready var common_translations = dials["common_translations"]
onready var epilogue = dials["epilogue"]

func _ready():
	var ambiant_sfx = AudioStreamPlayer.new()
	ambiant_sfx.volume_db = -12
	ambiant_sfx.stream = load("res://Assets/Sounds/ambiant.ogg")
	add_child(ambiant_sfx)
	ambiant_sfx.play()
	ambiant_sfx.pause_mode = Node.PAUSE_MODE_PROCESS


func start_main_menu():
	story_index = 0
	end = "introduction"
	switch_button = null
	get_tree().change_scene("res://Scenes/StartScreen.tscn")

func start_introduction():
	get_tree().change_scene("res://Scenes/Introduction.tscn")

func start_game():
	get_tree().change_scene("res://Game.tscn")

func start_epilogue():
	get_tree().change_scene("res://Scenes/Introduction.tscn")

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

func get_common_translated_text(key):
	return common_translations[key][language]

func get_credits_text():
	if language == "fr":
		return "This game was made by Jérôme Nutriz Gully and Pinky for the Godot Wild Jame #21.\n\nObvioussly it was made with the amazing open source Godot Engine (https://godotengine.org/)\n\nKeep in touch: https://twitter.com/JeromeGully\nSource Code: https://github.com/Nutriz/GodotWildJam21"
	else:
		return "This game was made by Jérôme Nutriz Gully and Pinky for the Godot Wild Jame #21.\n\nObvioussly it was made with the amazing open source Godot Engine (https://godotengine.org/)\n\nKeep in touch: https://twitter.com/JeromeGully\nSource Code: https://github.com/Nutriz/GodotWildJam21"

func get_good_end():
	return epilogue.good[language]

func get_bad_end():
	return epilogue.bad[language]

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
				var text =  curr_dial[msg_index].name + ": " + Global.get_translated_text(curr_dial[msg_index])
				if text.length() > 146:
					debug_text.text += "\nTEXT TO LONG -> "
				debug_text.text += "\n" + text


			else:
				for b in curr_dial[msg_index]:
					debug_text.text += "\n" + b
					for answer_index in curr_dial[msg_index][b].size():
						var text = "\n\t" + curr_dial[msg_index][b][answer_index].name + ": " + Global.get_translated_text(curr_dial[msg_index][b][answer_index])
						if text.length() > 146:
							debug_text.text += "\n**** TOO LONG -> " + text
						else:
							debug_text.text += "\n" + text

		debug_text.text += "\n"
