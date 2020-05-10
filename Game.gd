extends Node2D

func _ready():
	Events.connect("jack_connected", self, "test")
	$JackA.initial_position = $PositionJackA.position
	$JackB.initial_position = $PositionJackB.position

func _process(delta):
	if Input.is_action_pressed("quit"):
		get_tree().quit()

func test(jack_type, input):
	print(str(jack_type) + " connected to " + str(Global.Inputs.keys()[input]))
