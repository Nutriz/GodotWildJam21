extends Panel

var msg

func _ready():
	pass

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
	$Text.visible_characters = msg.name.length() + Global.get_translated_text(msg).length() + 8

func display_indicator(must_display):
	$NextIndicator.visible = must_display

func _on_next_character_timeout():
	if msg.pos == "caller":
		if ($Text.visible_characters == $Text.text.length()):
			$NextCharacter.stop()
			print("stop timer")
			if msg.has("holding"):
				Events.emit_signal("can_be_holded", self)
			else:
				display_indicator(true)
		else:
			handle_word_sound()
			$Text.visible_characters += 1
	else:
		if ($Text.visible_characters == msg.name.length() + Global.get_translated_text(msg).length() + 2):
			$NextCharacter.stop()
			print("stop timer")
			display_indicator(true)
		else:
			handle_word_sound()
			$Text.visible_characters += 1

func handle_word_sound():
	if $Text.text[$Text.visible_characters] == " ":
		var i = 1
		while $Text.visible_characters + i < $Text.text.length() and $Text.text[$Text.visible_characters + i] != " ":
			i += 1
		print("next word len: " + str(i-1))

		if i <= 3:
			$Voice.play()
		elif i <= 6:
			$Voice.play()
			yield(get_tree().create_timer(0.1), "timeout")
			$Voice.play()
		else:
			$Voice.play()
			yield(get_tree().create_timer(0.1), "timeout")
			$Voice.play()
			yield(get_tree().create_timer(0.1), "timeout")
			$Voice.play()
#		else:
#			if $Text.text[$Text.visible_characters] == " ":
#				printt("space pos ", $Text.visible_characters + 1)
#				var i = 1
#				while $Text.text[$Text.visible_characters + i] != " ":
#					i += 1
#					if $Text.visible_characters + i >= $Text.text.length():
#						print("returnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn")
#						$Text.visible_characters += 1
#						return
#				print("next word len: " + str(i-1))
#			$Text.visible_characters += 1
