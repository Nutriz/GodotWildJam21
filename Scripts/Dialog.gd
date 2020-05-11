extends Panel

var msg

func _ready():
	pass

func display_msg(msg):
	self.msg = msg
	visible = true
	display_indicator(false)

	$Text.text = msg.name + ": " + msg.text
	$Text.visible_characters = msg.name.length() + 1
	$NextCharacter.start()

func hide():
	visible = false
	display_indicator(false)

func is_at_end_of_text():
	return $NextIndicator.visible

func skip_to_end_of_text():
	$Text.visible_characters = msg.name.length() + msg.text.length() + 8

func display_indicator(must_display):
	$NextIndicator.visible = must_display

func _on_next_character_timeout():
	if msg.pos == "caller":
		if ($Text.visible_characters == msg.name.length() + msg.text.length() + 8):
			if msg.has("holding"):
				Events.emit_signal("can_be_holded", self)
			else:
				display_indicator(true)
		else:
			$Text.visible_characters += 1
	else:
		if ($Text.visible_characters == msg.name.length() + msg.text.length() + 8):
			display_indicator(true)
		else:
			$Text.visible_characters += 1
