extends Node2D

var picked
onready var initial_position = position

func _process(delta):
	if picked:
		position = get_global_mouse_position()

func _on_PickArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			picked = event.pressed
			if not event.pressed and not $Area.get_overlapping_areas().empty():
				var input_overlapped = $Area.get_overlapping_areas().front()
				if (name == "JackA" and input_overlapped.is_in_group("inputsA")) or (name == "JackB" and input_overlapped.is_in_group("inputsB")):
					Events.emit_signal("jack_connected", name, $Area.get_overlapping_areas().front().get_parent().input)
				else:
					reset_position()
			else:
				reset_position()

func reset_position():
	position = initial_position
