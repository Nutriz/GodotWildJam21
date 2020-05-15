extends Control

func _ready():
	$AnimationPlayer.play("Bg")
	$Label.text = Global.introduction["text_" + str(Global.language)]


func _process(delta):
	if Input.is_action_just_pressed("skip"):
		$AnimationPlayer.stop()
		$AnimationPlayer2.play("Bg")
		yield(get_tree().create_timer(1.4), "timeout")
		Global.start_game()
