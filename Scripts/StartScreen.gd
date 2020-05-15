extends Control

func _ready():
	$Menu/Language.select(1)
	load_language(1)

func _on_Language_item_selected(index):
	load_language(index)

func load_language(index):
	Global.load_language()

	if index == 1:
		$Menu/Start.text = "Démarrer"
		$Menu/Credits.text = "Crédits"
		$Menu/Quit.text = "Quitter"
		Global.language = "fr"
	else:
		$Menu/Start.text = "Start Game"
		$Menu/Credits.text = "Credits"
		$Menu/Quit.text = "Quit"
		Global.language = "en"

func _on_Quit_pressed():
	get_tree().quit()

func _on_Start_pressed():
	Global.start_introduction()
