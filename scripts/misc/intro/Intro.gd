extends Control

func _ready():
	Utils.checkFiles()
	Settings.apply_onstart()
	randomize()
	var prob = randi()%100+1
	if prob == 1:
		$Logo.texture = load("res://sprites/logo-egg.png")
		$Label.bbcode_text = "[center][rainbow freq=0.6][tornado radius=5 freq=4]LaughingPie and Co.[/tornado][/rainbow][/center]"
	_play_anim()

func _play_anim():
	$AnimationPlayer.play("Fade")
	yield($AnimationPlayer, "animation_finished")
	yield(get_tree().create_timer(1), "timeout")
	$AnimationPlayer.play_backwards("Fade")
	yield($AnimationPlayer, "animation_finished")
	_godot_credits()
	$AnimationPlayer.play("Fade")
	yield($AnimationPlayer, "animation_finished")
	yield(get_tree().create_timer(1), "timeout")
	$AnimationPlayer.play_backwards("Fade")
	yield($AnimationPlayer, "animation_finished")
	ModLoader.apply_check()
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")

func _godot_credits():
	$Logo.texture = load("res://sprites/icons/misc/godot_logo.svg")
	$Label.bbcode_text = "[center][tornado radius=5 freq=4]Made with Godot[/tornado][/center]"

#func _facts():
#	randomize()
#	var facts = randi()%3+1
#	if facts == 1:
#		SceneTransition.change_scene("res://scenes/misc/intro/Facts.tscn")
#	else:
#		ModLoader.apply_check()
#		SceneTransition.change_scene("res://scenes/MainMenu.tscn")
