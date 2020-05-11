extends Node2D

var connectionA
var connectionB

func _ready():
	Events.connect("jack_connected", self, "on_jack_connected")
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
	print(str(jack_name) + " connected to " + str(Global.Inputs.keys()[input]))
	if jack_name.ends_with("A"):
		connectionA = input
	else:
		connectionB = input

func on_dialogue_finished():
	print("reset")
	$JackA.reset_position()
	$JackB.reset_position()
	$CheckButton.pressed = false

func _on_holding_toggled(button_pressed):
	if button_pressed and connectionA != null:
		print("emit " + str(connectionA))
		Events.emit_signal("holding_input")

func on_can_be_holded(input):
	$CheckButton.disabled = false

func _on_CallTimer_timeout():
	var index = randi() % 5
	$Inputs.get_children()[index].start_call()
