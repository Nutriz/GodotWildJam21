extends Control

func _ready():
	$AnimationPlayer.play("Bg")

	if Global.end == "good":
		$Label.text = Global.get_good_end()
	elif Global.end == "bad":
		$Label.text = Global.get_bad_end()
	else:
		$Label.text = Global.introduction["text_" + str(Global.language)]


func _process(delta):
	if Input.is_action_just_pressed("skip"):

		$AnimationPlayer.stop()
		$AnimationPlayer2.play("Bg")
		yield(get_tree().create_timer(1.4), "timeout")

		if Global.end == "good" or Global.end == "bad":
			Global.start_main_menu()
		else:
			Global.start_game()
