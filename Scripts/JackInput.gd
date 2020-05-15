extends Node2D

var is_ringing = false

func _ready():
	if get_index_num() <= 20:
		$Label.text = str(((get_index_num()-1)%5)+1)
		$InputArea.add_to_group("inputsA")
	else:
		$Label.text = str(((get_index_num()-1)%5)+1)
		if name == "B26":
			$Label.text = "6"
		$InputArea.add_to_group("inputsB")

func start_ringing():
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

func get_index_num():
	return int(name.substr(1))
