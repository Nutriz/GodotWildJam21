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

	if Input.is_action_pressed("quit"):
		get_tree().quit()

	if Input.is_action_just_pressed("debug"):
		$Debug.visible = true
		Global.display_debug($Debug/Text)


func on_jack_connected(jack_name, jack_input):
	print(str(jack_name) + " connected to " + str(jack_input.get_index_num()))
	jack_input.set_connected()
	$SFX/Ringing.stop()
	if jack_name.ends_with("A"):
		jack_input.set_connected()
		if jack_input.is_ringing:
			connectionA = jack_input
			Events.emit_signal("start_dialogue")
		else:
			yield(get_tree().create_timer(0.5), "timeout")
			$SFX/Noise1.play()
	elif connectionA != null and not $HoldSwitch.disabled:
		connectionB = jack_input
		jack_input.hold_call()

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
	var index = randi() % 20
	$Inputs.get_children()[index].start_ringing()
	$SFX/Ringing.play()
