extends Control

var story_index = 0

var chapter_idx = 1
var curr_dial = null
var msg_index = 0

var boss_monologue = false

func _ready():
	Events.connect("start_dialogue", self, "on_start_dialogue")
	Events.connect("start_answer", self, "on_start_answer")
	Events.connect("holding_input", self, "on_holding")

func _process(delta):
	if Input.is_action_just_pressed("skip") and curr_dial != null:

		if boss_monologue:
			if not $BossDialog.is_at_end_of_text():
				$BossDialog.skip_to_end_of_text()
			elif is_last_message():
				boss_monologue = false
				curr_dial = null
				get_tree().paused = false
				$BossDialog.queue_free()
			else:
				msg_index += 1
				$BossDialog.display_msg(curr_dial[msg_index])
			return

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

func on_start_dialogue():
	msg_index = 0
	start_new_dialog()
	display_next_message()

func on_start_answer(input):
	msg_index = 0
	var dial_length = curr_dial.size() - 1
	if curr_dial[dial_length].has("B" + str(input.get_index_num() - 20)):
		curr_dial = curr_dial[dial_length]["B" + str(input.get_index_num() - 20)]
	else:
		print("no entry, default answer")

	display_next_message()

func start_new_dialog():
	randomize()
	if randi() % 2 == 0:
		story_index += 1
		print("start new story dialogue, index: " + str(story_index))
		curr_dial = Global.main_story["dial" + str(story_index)]
	else:
		var max_index = Global.secondary_stories.size()
		var index = (randi() % max_index) + 1
		assert(index > 0)
		print("start new secondary story dialogue, index: " + str(index))
		curr_dial = Global.secondary_stories["dial" + str(index)]

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

func start_boss_monologue():
	boss_monologue = true
	curr_dial = Global.boss_dialogue
	$BossDialog.display_msg(curr_dial[0])
