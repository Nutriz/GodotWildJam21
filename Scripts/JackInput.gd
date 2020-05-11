extends Node2D

export(Global.Inputs) var input

func _ready():
	$Label.text = "Entrée " + str(Global.Inputs.keys()[input])

	if input < 5:
		$InputArea.add_to_group("inputsA")
	else:
		$InputArea.add_to_group("inputsB")

func start_call():
	$AnimationPlayer.play("Red indicator")

func online():
	$AnimationPlayer.stop()
	$AnimationPlayer.current_animation_position = 0.3

func hold_call():
	$AnimationPlayer.stop()
	$AnimationPlayer.current_animation_position = 0.3
