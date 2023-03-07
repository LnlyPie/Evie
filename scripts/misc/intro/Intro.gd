extends Control

func _ready():
	Utils.checkFiles()
#	Settings.apply_onstart()
	randomize()
	var prob = randi()%100+1
	if prob == 1:
		$LonelyPieLogo.texture = load("res://sprites/logo-egg.png")
		$LonelyPieLabel.bbcode_text = "[center][rainbow][tornado radius=5 freq=2][shake]LaughingPie and Co.[/shake][/tornado][/rainbow][/center]\n"
	yield(get_tree().create_timer(1), "timeout")
	randomize()
	var facts = randi()%3+1
	if facts == 1:
		SceneTransition.change_scene("res://scenes/misc/intro/Facts.tscn")
	else:
		ModLoader.apply_check()
		SceneTransition.change_scene("res://scenes/MainMenu.tscn")
