extends Node2D

var picked
var connected_input setget connected_set
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
				if (name == "JackA" and input_overlapped.is_in_group("inputsA")) or (name == "JackB" and input_overlapped.is_in_group("inputsB") and Global.switch_button.pressed):
					var input = $Area.get_overlapping_areas().front().get_parent()
					self.connected_input = input
				else:
					reset_position()
			else:
				reset_position()

func reset_position():
	position = initial_position
	self.connected_input = null

func connected_set(new_value):
	if new_value != null:
		Events.emit_signal("jack_connected", name, new_value)
	elif connected_input != null:
		Events.emit_signal("jack_disconnected", name, connected_input)
	connected_input = new_value
