extends Node2D

var connectionA
var connectionB

func _ready():
	Events.connect("jack_connected", self, "on_jack_connected")
	Events.connect("dialogue_finished", self, "on_dialogue_finished")

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

func on_jack_connected(jack_type, input):
	print(str(jack_type) + " connected to " + str(Global.Inputs.keys()[input]))
	if jack_type.ends_with("A"):
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
