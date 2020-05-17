extends Light2D

var is_ringing = false

func _ready():
	if get_index_num() <= 20:
		$LabelInput.text = str(((get_index_num()-1)%5)+1)
		$InputArea.add_to_group("inputsA")
	else:
		var text = Global.get_common_translated_text("output")
		$LabelOutput.text = text + str(((get_index_num()-1)%5)+1)
		if name == "B26":
			$LabelOutput.text = Global.get_common_translated_text("output") + str("6")
		$InputArea.add_to_group("inputsB")
		$Input.visible = false
		$InputIndicator.visible = false
		$LabelInput.visible = false
		$Output.visible = true
		$OutputIndicator.visible = true
		$LabelOutput.visible = true
		enabled = false

func start_ringing():
	is_ringing = true
	$InputPlayer.play("InputAnimation")

func set_light_on():
	if get_index_num() <= 20:
		$InputPlayer.play("InputAnimation")
		$InputPlayer.stop()
		$InputPlayer.seek(0.3, true)
	else:
		$LongLight.visible = true
		$LongLight.enabled = true

func set_light_off():
	if get_index_num() <= 20:
		$InputPlayer.stop()
		$InputPlayer.seek(0, true)
	else:
		$LongLight.visible = false
		$LongLight.enabled = false

func set_light_blink():
	$InputPlayer.stop(true)
	$InputPlayer.play("InputAnimation")

func _on_jack_area_entered(area):
	$OnOverSfx.play()

func _on_InputArea_input_event(viewport, event, shape_idx):
	print("callback input")

func get_index_num():
	return int(name.substr(1))
