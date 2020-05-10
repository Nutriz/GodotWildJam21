extends Node2D

onready var jack_type = name
var picked
onready var initial_position = position

func _process(delta):
	if picked:
		position = get_global_mouse_position()

func _on_PickArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			picked = event.pressed
			if event.pressed == false and not $Area.get_overlapping_areas().empty():
				if $Area.get_overlapping_areas().front().is_in_group("inputs"):
					Events.emit_signal("jack_connected", jack_type, $Area.get_overlapping_areas().front().get_parent().input)
			else:
				reset_position()

func reset_position():
	position = initial_position
