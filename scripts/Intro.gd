extends Node2D

func _ready():
	randomize()
	var prob = randi()%100
	if prob == 1:
		$Sprite.texture = load("res://sprites/logo-egg.png")
		$RichTextLabel.bbcode_text = "[center][rainbow][tornado radius=5 freq=2][shake]LaughingPie and Co.[/shake][/tornado][/rainbow][/center]\n"
	yield(get_tree().create_timer(2), "timeout")
	SceneTransition.change_scene("res://scenes/misc/intro/AutoSaveMessage.tscn")
