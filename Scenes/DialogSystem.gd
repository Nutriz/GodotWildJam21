extends Control

onready var dials = load_dialogue("res://Assets/Dialogues/dialogues.json.gd")

var chapter_idx = 1
var curr_dial = null
var msg_index = 0

func _ready():
	Events.connect("jack_connected", self, "on_jack_connected")
	Events.connect("holding_input", self, "on_holding")

func _process(delta):
	if Input.is_action_just_pressed("skip") and curr_dial != null:

		if get_curr_message().has("end"):
			print("emit end")
			Events.emit_signal("dialogue_finished")
			curr_dial = null
			$CallerDialog.hide()
			$CalledDialog.hide()
		elif get_curr_message().pos == "caller":
			if not $CallerDialog.is_at_end_of_text():
				$CallerDialog.skip_to_end_of_text()
			elif get_curr_message().has("holding"):
				return
			else:
				msg_index += 1
				display_next_message()
		else:
			if not $CalledDialog.is_at_end_of_text():
				$CalledDialog.skip_to_end_of_text()
			elif get_curr_message().has("holding"):
				return
			else:
				msg_index += 1
				display_next_message()

func load_dialogue(file_path):
	var file = File.new()
	assert(file.file_exists(file_path), "file don't exist")

	file.open(file_path, file.READ)
	var dialogues = parse_json(file.get_as_text())
	assert(dialogues.size() > 0, "dialogue is empty")
	return dialogues

func on_jack_connected(jack_type, input):
	msg_index = 0

	if jack_type.ends_with("A"):
		curr_dial = dials["chapter" + str(chapter_idx)]["dial1"]
	else:
		var dial_length = dials["chapter" + str(chapter_idx)]["dial1"].size() - 1
		curr_dial = dials["chapter" + str(chapter_idx)]["dial1"][dial_length]["B" + str(input + 1 - 5)]

	display_next_message()

func on_holding():
	print("received")
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
