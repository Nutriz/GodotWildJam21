extends Control

var curr_dial = null
var msg_index = 0
var caller_name

var boss_monologue = false
var techman_dial = false

var first_dial = true

var binding = {"X1": 1, "X2": 2, "X3": 3, "X4": 4, "X5": 5, "X6": 6}

func _ready():
	Events.connect("start_dialogue", self, "on_start_dialogue")
	Events.connect("start_answer", self, "on_start_answer")
	Events.connect("holding_input", self, "on_holding")

	for i in range(10):
		randomize_outputs()

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
				$BossDialog.display_msg(curr_dial[msg_index], null)
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
				if Global.henry_annoyed == 4 and caller_name == "Henri":
					Global.henry_annoyed += 1
					$CallerDialog.display_msg(Global.bad_end[0], null)
				else:
					finish_and_close()
			else:
				msg_index += 1
				display_next_message()
		else:
			if not $CalledDialog.is_at_end_of_text():
				$CalledDialog.skip_to_end_of_text()
			elif is_last_message():
				if Global.henry_annoyed == 4 and caller_name == "Henri":
					Global.henry_annoyed += 1
					$CallerDialog.display_msg(Global.bad_end[0], null)
				else:
					finish_and_close()
			else:
				msg_index += 1
				display_next_message()

func finish_and_close():
	curr_dial = null
	$CallerDialog.hide()
	$CalledDialog.hide()
	Events.emit_signal("dialogue_finished")
	get_tree().paused = false

func on_start_dialogue():
	msg_index = 0
	start_new_dialog()
	display_next_message()

func on_start_answer(input):

	get_tree().paused = true

	msg_index = 0
	caller_name = curr_dial[0].name

	var binded_index = binding["X" + str(input.get_index_num() - 20)]
	printt(input.name, "binded to", binded_index)

	var dial_length = curr_dial.size() - 1
	if caller_name == "Henri":
		print("it's Henri")
		if binded_index == 1: # Henri to Joséphine
			print("It's Henri, story will continue")
			Global.henry_annoyed = 0
			curr_dial = curr_dial[dial_length]["Josephine"]
		else:
			print("Not Joséphine")
			Global.story_index -= 1
			Global.henry_annoyed += 1
			msg_index = 0
			var other_perso_dial = Global.other_dest_people["B" + str(binded_index)]
			var other_index = randi() % other_perso_dial.size()
			printt("size", other_perso_dial.size(), "other_index", other_index)
			curr_dial = other_perso_dial[other_index]
	else:
		print("Caller is not Henri")
		msg_index = 0
		var other_perso_dial = Global.other_dest_people["B" + str(binded_index)]
		var other_index = randi() % other_perso_dial.size()
		printt("size", other_perso_dial.size(), "other_index", other_index)
		curr_dial = other_perso_dial[other_index]

	display_next_message()

func start_new_dialog():
	get_tree().paused = true
	randomize()

	if first_dial:
		print("**** first dialogue")
		first_dial = false
		Global.story_index += 1
		print("start new story dialogue, index: " + str(Global.story_index))
		curr_dial = Global.main_story["dial" + str(Global.story_index)]
	elif randi() % 2 == 0:
		Global.story_index += 1
		print("start new story dialogue, index: " + str(Global.story_index))
		curr_dial = Global.main_story["dial" + str(Global.story_index)]
	else:
		var max_index = Global.secondary_stories.size()
		var index = (randi() % max_index)
		print("start new secondary story dialogue, index: " + str(index))
		curr_dial = Global.secondary_stories[index]

func on_holding():
	get_tree().paused = false
	$CallerDialog.hide()
	$CalledDialog.hide()

func display_next_message():
	var msg = get_curr_message()
	if msg.pos == "caller":
		$CallerDialog.display_msg(msg, caller_name)
		$CalledDialog.hide()
	else:
		$CallerDialog.hide()
		$CalledDialog.display_msg(msg, caller_name)

func get_curr_message():
	return curr_dial[msg_index]

func is_last_message():
	return msg_index == curr_dial.size() - 1

func start_boss_monologue():
	msg_index = 0
	boss_monologue = true
	curr_dial = Global.boss_dialogue
	$BossDialog.display_msg(curr_dial[0], caller_name)

func start_tech_man_dialog(count):
	msg_index = 0
	techman_dial = true
	get_tree().paused = true

	curr_dial = Global.techman_dialogue[count].duplicate()
	if count > 0:
		var value_switched = new_output_binding(count)
		replace_placeholder(curr_dial, value_switched)

	$TechManDialog.display_msg(curr_dial, caller_name)

func new_output_binding(count):
	randomize()

	var list_to_pick = binding.duplicate()
	var index = [1, 2, 3, 4, 5, 6]
	index.shuffle()

	match count:
		1:
			var key_a = "X" + str(index.pop_front())
			var value_a = list_to_pick[key_a]
			list_to_pick.erase(key_a)
			var key_b = "X" + str(index.pop_front())
			var value_b = list_to_pick[key_b]

			printt("want to switch ", value_a, "with", value_b)

			binding[key_a] = value_b
			binding[key_b] = value_a
			return [value_a, value_b]
		2:
			var key_a = "X" + str(index.pop_front())
			var value_a = list_to_pick[key_a]
			list_to_pick.erase(key_a)
			var key_b = "X" + str(index.pop_front())
			var value_b = list_to_pick[key_b]
			var key_c = "X" + str(index.pop_front())
			var value_c = list_to_pick[key_c]
			list_to_pick.erase(key_c)
			var key_d = "X" + str(index.pop_front())
			var value_d = list_to_pick[key_d]

			printt("want to switch ", value_a, "with", value_b)
			printt("and want to switch ", value_c, "with", value_d)

			binding[key_a] = value_b
			binding[key_b] = value_a
			binding[key_c] = value_d
			binding[key_d] = value_c
			return [value_a, value_b, value_c, value_d]

func replace_placeholder(curr_dial, value_switched):
	curr_dial.text_fr = curr_dial.text_fr.replace("$A", value_switched[0])
	curr_dial.text_fr = curr_dial.text_fr.replace("$B", value_switched[1])
	curr_dial.text_en = curr_dial.text_en.replace("$A", value_switched[0])
	curr_dial.text_en = curr_dial.text_en.replace("$B", value_switched[1])

	if value_switched.size() == 4:
		curr_dial.text_fr = curr_dial.text_fr.replace("$C", value_switched[2])
		curr_dial.text_fr = curr_dial.text_fr.replace("$D", value_switched[3])
		curr_dial.text_en = curr_dial.text_en.replace("$C", value_switched[2])
		curr_dial.text_en = curr_dial.text_en.replace("$D", value_switched[3])

func randomize_outputs():
	randomize()

	var list_to_pick = binding.duplicate()
	var index = [1, 2, 3, 4, 5, 6]
	index.shuffle()

	var key_a = "X" + str(index.pop_front())
	var value_a = list_to_pick[key_a]
	list_to_pick.erase(key_a)
	var key_b = "X" + str(index.pop_front())
	var value_b = list_to_pick[key_b]

	binding[key_a] = value_b
	binding[key_b] = value_a
