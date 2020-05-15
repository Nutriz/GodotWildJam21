extends Panel

var msg

func display_msg(msg):
	self.msg = msg
	visible = true
	display_indicator(false)

	$Text.text = msg.name + ": " + Global.get_translated_text(msg)
	$Text.visible_characters = msg.name.length() + 1
	$NextCharacter.start()

func hide():
	visible = false
	display_indicator(false)

func is_at_end_of_text():
	return $NextIndicator.visible

func skip_to_end_of_text():
	$Text.visible_characters = msg.name.length() + Global.get_translated_text(msg).length()

func display_indicator(must_display):
	$NextIndicator.visible = must_display

func _on_next_character_timeout():
	if msg.pos == "caller":
		if ($Text.visible_characters == $Text.text.length()):
			$NextCharacter.stop()
			if msg.has("holding"):
				Events.emit_signal("can_be_holded", self)
			else:
				display_indicator(true)
		else:
#			handle_word_sound()
			$Text.visible_characters += 1
	else:
		if ($Text.visible_characters == msg.name.length() + Global.get_translated_text(msg).length() + 2):
			$NextCharacter.stop()
			display_indicator(true)
		else:
#			handle_word_sound()
			$Text.visible_characters += 1

func handle_word_sound():
	if $Text.text[$Text.visible_characters] == " ":
		var word_len = 1
		while $Text.visible_characters + word_len < $Text.text.length() and $Text.text[$Text.visible_characters + word_len] != " ":
			word_len += 1

		print("next word len: " + str(word_len-1))

		randomize()
		var i = (randi() % 2) + 1
		if word_len <= 3:
			$VoiceSystem.get_node("ManShort" + str(i)).play()
		elif word_len <= 7:
			$VoiceSystem.get_node("ManMid" + str(i)).play()
		else:
			$VoiceSystem.get_node("ManLong" + str(i)).play()
