extends Control

var chapter_idx = 1
var curr_dial = null
var msg_index = 0

var boss_monologue = false
var techman_dial = false

var binding = {"X1": "B1", "X2": "B2", "X3": "B3", "X4": "B4", "X5": "B5", "X6": "B6"}

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

		elif techman_dial:
			if not $TechManDialog.is_at_end_of_text():
				$TechManDialog.skip_to_end_of_text()
			else:
				techman_dial = false
				curr_dial = null
				$TechManDialog.visible = false
				get_tree().paused = false
			return

		elif get_curr_message().pos == "caller":
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

	var bindined = binding["X" + str(input.get_index_num() - 20)]
	printt(input.name, "binded to", bindined)
	var binded_index = bindined[1]

	var dial_length = curr_dial.size() - 1
	if curr_dial[dial_length].has(bindined):
		curr_dial = curr_dial[dial_length][bindined]
	else:
		print("no entry, default answer")

	display_next_message()

func start_new_dialog():
	randomize()
#	if randi() % 2 == 0:
	Global.story_index += 1
	print("start new story dialogue, index: " + str(Global.story_index))
	curr_dial = Global.main_story["dial" + str(Global.story_index)]
#	else:
#		var max_index = Global.secondary_stories.size()
#		var index = (randi() % max_index) + 1
#		assert(index > 0)
#		print("start new secondary story dialogue, index: " + str(index))
#		curr_dial = Global.secondary_stories["dial" + str(index)]

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
	msg_index = 0
	boss_monologue = true
	curr_dial = Global.boss_dialogue
	$BossDialog.display_msg(curr_dial[0])

func start_tech_man_dialog(count):
	msg_index = 0
	techman_dial = true
	get_tree().paused = true

	var new_binding = new_output_binding(count)
	curr_dial = Global.techman_dialogue[count].duplicate()
	replace_placeholder(curr_dial, new_binding)

	$TechManDialog.display_msg(curr_dial)


func replace_placeholder(curr_dial, new_binding):
	curr_dial.text_fr = curr_dial.text_fr.replace("$A", new_binding[0])
	curr_dial.text_fr = curr_dial.text_fr.replace("$B", new_binding[1])
	curr_dial.text_en = curr_dial.text_en.replace("$A", new_binding[0])
	curr_dial.text_en = curr_dial.text_en.replace("$B", new_binding[1])

	if new_binding.size() == 4:
		curr_dial.text_fr = curr_dial.text_fr.replace("$C", new_binding[2])
		curr_dial.text_fr = curr_dial.text_fr.replace("$D", new_binding[3])
		curr_dial.text_en = curr_dial.text_en.replace("$C", new_binding[2])
		curr_dial.text_en = curr_dial.text_en.replace("$D", new_binding[3])

func new_output_binding(count):
	randomize()

	var list_to_pick = [1, 2, 3, 4, 5, 6]

	match count:
		1:
			var index_a = list_to_pick[randi() % 6]
			list_to_pick.remove(index_a)
			var index_b = list_to_pick[randi() % 5]

			printt("want to switch ", index_a, "with", index_b)

			binding["X" + str(index_a)] = "B" + str(index_b)
			binding["X" + str(index_b)] = "B" + str(index_a)
			return ["B" + str(index_a), "B" + str(index_b)]
		2:
			var index_a = list_to_pick[randi() % 6]
			list_to_pick.remove(index_a)
			var index_b = list_to_pick[randi() % 5]
			list_to_pick.remove(index_b)
			var index_c = list_to_pick[randi() % 4]
			list_to_pick.remove(index_c)
			var index_d = list_to_pick[randi() % 3]

			printt("want to switch ", index_a, "with", index_b)
			printt("and want to switch ", index_c, "with", index_d)

			binding["X" + str(index_a)] = "B" + str(index_b)
			binding["X" + str(index_b)] = "B" + str(index_a)
			binding["X" + str(index_c)] = "B" + str(index_d)
			binding["X" + str(index_d)] = "B" + str(index_c)
			return ["B" + str(index_a), "B" + str(index_b),  "B" + str(index_c),  "B" + str(index_d)]
