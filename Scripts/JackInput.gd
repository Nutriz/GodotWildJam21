extends Node2D

export(Global.Inputs) var input

var is_ringing = false

func _ready():
	$Label.text = "Entrée " + str(Global.Inputs.keys()[input])

	if input < 5:
		$InputArea.add_to_group("inputsA")
	else:
		$InputArea.add_to_group("inputsB")

func start_call():
	is_ringing = true
	$AnimationPlayer.play("Red indicator")

func set_connected():
	$AnimationPlayer.play("Red indicator")
	$AnimationPlayer.stop()
	$AnimationPlayer.seek(0.3, true)

func set_disconnected():
	$AnimationPlayer.stop()
	$AnimationPlayer.seek(0, true)

func hold_call():
	$AnimationPlayer.stop(true)
	$AnimationPlayer.play("Red indicator")

func _on_jack_area_entered(area):
	$OnOverSfx.play()


func _on_InputArea_input_event(viewport, event, shape_idx):
	print("callback input")
