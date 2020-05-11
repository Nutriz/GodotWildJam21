extends Control

onready var dials = load_dialogue("res://Assets/Dialogues/dialogues.json.gd")
onready var main_story = dials["main_story"]
onready var secondary_stories = dials["secondary_stories"]

var story_index = 0

var chapter_idx = 1
var curr_dial = null
var msg_index = 0

func _ready():
	Events.connect("start_dialogue", self, "on_start_dialogue")
	Events.connect("start_answer", self, "on_start_answer")
	Events.connect("holding_input", self, "on_holding")

func _process(delta):
	if Input.is_action_just_pressed("skip") and curr_dial != null:
		if get_curr_message().pos == "caller":
			if not $CallerDialog.is_at_end_of_text():
				$CallerDialog.skip_to_end_of_text()
			elif get_curr_message().has("holding"):
				return
			elif is_last_message():
				finish_and_close()
			else:
				msg_index += 1
				display_next_message()
		else:
			if not $CalledDialog.is_at_end_of_text():
				$CalledDialog.skip_to_end_of_text()
			elif is_last_message():
				finish_and_close()
			else:
				msg_index += 1
				display_next_message()

func finish_and_close():
	curr_dial = null
	$CallerDialog.hide()
	$CalledDialog.hide()
	Events.emit_signal("dialogue_finished")

func load_dialogue(file_path):
	var file = File.new()
	assert(file.file_exists(file_path), "file don't exist")

	file.open(file_path, file.READ)
	var dialogues = parse_json(file.get_as_text())
	assert(dialogues.size() > 0, "dialogue is empty")
	return dialogues

func on_start_dialogue():
	msg_index = 0
	start_new_dialog()
	display_next_message()

func on_start_answer(input):
	msg_index = 0
	var dial_length = curr_dial.size() - 1
	if curr_dial[dial_length].has("B" + str(input + 1 - 5)):
		curr_dial = curr_dial[dial_length]["B" + str(input + 1 - 5)]
	else:
		print("no entry, default answer")

	display_next_message()

func start_new_dialog():
	randomize()
	if randi() % 2 == 0:
		story_index += 1
		print("start new story dialogue, index: " + str(story_index))
		curr_dial = main_story["dial" + str(story_index)]
	else:
		var max_index = secondary_stories.size()
		var index = (randi() % max_index) + 1
		assert(index > 0)
		print("start new secondary story dialogue, index: " + str(index))
		curr_dial = secondary_stories["dial" + str(index)]

func on_holding():

	$CallerDialog.hide()
	$CalledDialog.hide()

func display_next_message():
	var msg = get_curr_message()
	if msg.pos == "caller":
		$CallerDialog.display_msg(msg)
		$CalledDialog.hide()
	else:
		$CallerDialog.hide()
		$CalledDialog.display_msg(msg)

func get_curr_message():
	return curr_dial[msg_index]

func is_last_message():
	return msg_index == curr_dial.size() - 1
