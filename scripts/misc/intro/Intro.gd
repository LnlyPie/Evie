extends Node2D

func _ready():
	randomize()
	var prob = randi()%100
	if prob == 1:
		$LonelyPieLogo.texture = load("res://sprites/logo-egg.png")
		$LonelyPieLabel.bbcode_text = "[center][rainbow][tornado radius=5 freq=2][shake]LaughingPie and Co.[/shake][/tornado][/rainbow][/center]\n"
	yield(get_tree().create_timer(1), "timeout")
	# Change Scene automatically if autosave off
	# if [autosave turned off in settings]:
	#	SceneTransition.change_scene("res://scenes/MainMenu.tscn")
	# else:
	SceneTransition.change_scene("res://scenes/misc/intro/AutoSaveMessage.tscn")
