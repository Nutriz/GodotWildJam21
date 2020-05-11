extends Node2D

var connectionA
var connectionB

func _ready():
	Events.connect("jack_connected", self, "on_jack_connected")
	Events.connect("jack_disconnected", self, "on_jack_disconnected")
	Events.connect("dialogue_finished", self, "on_dialogue_finished")
	Events.connect("can_be_holded", self, "on_can_be_holded")

func _process(delta):

	$MouseToTrack.position = get_global_mouse_position()

	refresh_cable_position()

	if Input.is_action_pressed("quit"):
		get_tree().quit()

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
	if jack_name.ends_with("A"):
		if input.is_ringing:
			connectionA = input
			Events.emit_signal("start_dialogue")
		else:
			yield(get_tree().create_timer(0.5), "timeout")
			$Noise1.play()
	else:
		# TODO add if "is already in communication
		Events.emit_signal("start_answer", input.input)
		connectionB = input.input

func on_jack_disconnected(jack_name, connected_input):
	print(jack_name + " disconnected from " + str(connected_input))
	$Noise1.stop()
	connected_input.set_disconnected()

func on_dialogue_finished():
	print("reset")
	$JackA.reset_position()
	$JackB.reset_position()
	$CheckButton.pressed = false
	$CheckButton.disabled = true
	$CallTimer.start()

func _on_holding_toggled(button_pressed):
	if button_pressed and connectionA != null:
		connectionA.hold_call()
		Events.emit_signal("holding_input")

func on_can_be_holded(input):
	$CheckButton.disabled = false

func _on_call_timer_timeout():
	randomize()
	var index = randi() % 5
	$Inputs.get_children()[index].start_call()
