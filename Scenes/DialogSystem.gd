extends Control

var index = 0
onready var dials = load_dialogue("res://Assets/Dialogues/test.json")

func _ready():
	Events.connect("jack_connected", self, "on_jack_connected")

func _process(delta):
	if Input.is_action_just_pressed("skip"):
		var dial = dials["00" + str(index)]
		if ($LeftDialog/Text.visible_characters < dial.name.length() + dial.text.length() - 1):
			$LeftDialog/Text.visible_characters = dial.name.length() + dial.text.length()
		else:
			index += 1
			dial = dials["00" + str(index)]
			if dial.pos == "left":
				$LeftDialog.visible = true
				$RightDialog.visible = false
				$LeftDialog/Text.text = dial.name + ": " + dial.text
				$LeftDialog/Text.visible_characters = dial.name.length() + 1
				$Timer.start()
			else:
				$LeftDialog.visible = false
				$RightDialog.visible = true
				$RightDialog/Text.text = dial.name + ": " + dial.text
				$RightDialog/Text.visible_characters = dial.name.length() + 1
				$Timer.start()

func load_dialogue(file_path):
	var file = File.new()
	assert(file.file_exists(file_path), "file don't exist")

	file.open(file_path, file.READ)
	var dialogues = parse_json(file.get_as_text())
	assert(dialogues.size() > 0, "dialogue is empty")
	return dialogues

func on_jack_connected(jack_type, input):
	start_dialog()

func start_dialog():
	index += 1
	var dial = dials["00" + str(index)]
	if dial.pos == "left":
		$LeftDialog.visible = true
		$RightDialog.visible = false
		$LeftDialog/Text.text = dial.name + ": " + dial.text
		$LeftDialog/Text.visible_characters = dial.name.length() + 1
		$Timer.start()
	else:
		$LeftDialog.visible = false
		$RightDialog.visible = true
		$RightDialog/Text.text = dial.name + ": " + dial.text
		$RightDialog/Text.visible_characters = dial.name.length() + 1
		$Timer.start()

func _on_Timer_timeout():
	var dial = dials["00" + str(index)]
	if dial.pos == "left":
		$LeftDialog/Text.visible_characters += 1
	else:
		$RightDialog/Text.visible_characters += 1
