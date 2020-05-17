extends Node2D

var picked setget picked_set
var connected_input setget connected_set
onready var initial_position = position

func _ready():
	if name == "JackA":
		modulate = Color("#e1635a")
	else:
		modulate = Color("#437ec9")

func _process(delta):
	if name.ends_with("A"):
		$Cable.default_color = Color("#e1635a")
	else:
		$Cable.default_color = Color("#437ec9")

	if picked and connected_input == null:
		position = get_global_mouse_position()
	refresh_cable_position()

func refresh_cable_position():
	$Cable.clear_points()
	$Cable.add_point(to_local(initial_position))
	$Cable.add_point(Vector2(0, 0))

func _on_PickArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			self.picked = event.pressed
			if not picked and not $Area.get_overlapping_areas().empty():
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
	can_move()

func connected_set(new_value):
	if new_value != null:
		position = new_value.global_position
		$Sprite.visible = false
		$SpritePlugged.visible = true
		$JackIn.play()
		yield(get_tree().create_timer(0.7), "timeout")
		Events.emit_signal("jack_connected", self, new_value)
		connected_input = new_value
	elif connected_input != null:
		$Sprite.visible = true
		$SpritePlugged.visible = false
		Events.emit_signal("jack_disconnected", self, connected_input)
		connected_input = new_value

func dont_move():
	$Area/CollisionShape2D.disabled = true

func can_move():
	$Area/CollisionShape2D.disabled = false


func picked_set(new_value):
	picked = new_value
	if picked:
		$JackBeforePlug.play()
	else:
		$JackBeforePlug.stop()
