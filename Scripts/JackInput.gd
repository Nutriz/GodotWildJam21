extends Node2D

export(Global.Inputs) var input

func _ready():
	$Label.text = "Entrée " + str(Global.Inputs.keys()[input])
