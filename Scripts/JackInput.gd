extends Node2D

var is_ringing = false

func _ready():
	if get_index_num() <= 20:
		$LabelInput.text = str(((get_index_num()-1)%5)+1)
		$InputArea.add_to_group("inputsA")
	else:
		$LabelOutput.text = str(((get_index_num()-1)%5)+1)
		if name == "B26":
			$LabelOutput.text = "6"
		$InputArea.add_to_group("inputsB")
		$Input.visible = false
		$InputIndicator.visible = false
		$LabelInput.visible = false
		$Output.visible = true
		$OutputIndicator.visible = true
		$LabelOutput.visible = true

func start_ringing():
	is_ringing = true
	$InputPlayer.play("InputAnimation")

func set_light_on():
	$InputPlayer.play("InputAnimation")
	$InputPlayer.stop()
	$InputPlayer.seek(0.3, true)

	$OutputPlayer.play("OutputAnimation")
	$OutputPlayer.stop()
	$OutputPlayer.seek(0.3, true)

func set_light_off():
	$InputPlayer.stop()
	$InputPlayer.seek(0, true)

	$OutputPlayer.stop()
	$OutputPlayer.seek(0, true)

func set_light_blink():
	$InputPlayer.stop(true)
	$InputPlayer.play("InputAnimation")

	$OutputPlayer.stop(true)
	$OutputPlayer.play("OutputAnimation")

func _on_jack_area_entered(area):
	$OnOverSfx.play()


func _on_InputArea_input_event(viewport, event, shape_idx):
	print("callback input")

func get_index_num():
	return int(name.substr(1))
