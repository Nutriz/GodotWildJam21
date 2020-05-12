extends Node2D

var connectionA
var connectionB

func _ready():
	Events.connect("jack_connected", self, "on_jack_connected")
	Events.connect("jack_disconnected", self, "on_jack_disconnected")
	Events.connect("dialogue_finished", self, "on_dialogue_finished")
	Events.connect("can_be_holded", self, "on_can_be_holded")
	Global.switch_button = $HoldSwitch

func _process(delta):

	$MouseToTrack.position = get_global_mouse_position()

	refresh_cable_position()

	if Input.is_action_pressed("quit"):
		get_tree().quit()

	if Input.is_action_just_pressed("debug"):
		$Debug.visible = true
		$Debug/D.text += "***************************************\n"
		$Debug/D.text += "*             INTRODUCTION            *\n"
		$Debug/D.text += "***************************************\n"

		for msg in Global.introduction:
			$Debug/D.text += "\n" + msg

		$Debug/D.text += "\n\n\n***************************************\n"
		$Debug/D.text += "*              MAIN STORY             *\n"
		$Debug/D.text += "***************************************\n"

		debug(Global.main_story)

		$Debug/D.text += "\n\n***************************************\n"
		$Debug/D.text += "*          SECONDARIES STORY          *\n"
		$Debug/D.text += "***************************************\n"
		debug(Global.secondary_stories)

func debug(story):
	for dial in story:
		$Debug/D.text += "\n---------- " + dial + " ----------"
		var curr_dial = story[dial]
		for msg_index in curr_dial.size():
			if msg_index < curr_dial.size() - 1:
				$Debug/D.text += "\n" + curr_dial[msg_index].name + ": " + $DialogSystem/CallerDialog.get_text(curr_dial[msg_index])
			else:
				for b in curr_dial[msg_index]:
					$Debug/D.text += "\n" + b
					for answer_index in curr_dial[msg_index][b].size():
						if curr_dial[msg_index][b][answer_index].pos == "called":
							$Debug/D.text += "\n\t" + curr_dial[msg_index][b][answer_index].name + ": " + $DialogSystem/CallerDialog.get_text(curr_dial[msg_index][b][answer_index])
						else:
							$Debug/D.text += "\n\t" + curr_dial[msg_index][b][answer_index].name + ": " + $DialogSystem/CallerDialog.get_text(curr_dial[msg_index][b][answer_index])
		$Debug/D.text += "\n"

func refresh_cable_position():
	$CableJackA.remove_point(1)
	var point = $JackA/Cable.global_position - $PositionJackA.global_position
	$CableJackA.add_point(point)

	$CableJackB.remove_point(1)
	point = $JackB/Cable.global_position - $PositionJackB.global_position
	$CableJackB.add_point(point)

func on_jack_connected(jack_name, input):
	print(str(jack_name) + " connected to " + str(Global.Inputs.keys()[input.input]))
	input.set_connected()
	$SFX/Ringing.stop()
	if jack_name.ends_with("A"):
		if input.is_ringing:
			connectionA = input
			Events.emit_signal("start_dialogue")
		else:
			yield(get_tree().create_timer(0.5), "timeout")
			$SFX/Noise1.play()
	elif connectionA != null and not $HoldSwitch.disabled:
		connectionB = input.input

func on_jack_disconnected(jack_name, connected_input):
	print(jack_name + " disconnected from " + str(connected_input))
	$SFX/Noise1.stop()
	connected_input.set_disconnected()

func on_dialogue_finished():
	print("reset")
	$JackA.reset_position()
	$JackB.reset_position()
	$HoldSwitch.pressed = false
	$HoldSwitch.disabled = true
	randomize()
	$CallTimer.wait_time = rand_range(2, 10)
	$CallTimer.start()
	print("started new call timer with: " + str($CallTimer.wait_time))

func _on_holding_toggled(button_pressed):
	if button_pressed and connectionA != null:
		connectionA.hold_call()
		$SFX/HoldingNoise.play()
		Events.emit_signal("holding_input")
	else:
		Events.emit_signal("start_answer", connectionB)
		$SFX/HoldingNoise.stop()

func on_can_be_holded(input):
	$HoldSwitch.disabled = false

func _on_call_timer_timeout():
	randomize()
	var index = randi() % 5
	$Inputs.get_children()[index].start_ringing()
	$SFX/Ringing.play()
