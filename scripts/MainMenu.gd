extends Control

onready var gameVerFile = "res://version.txt"
var blockedSound = preload("res://sounds/gui/blocked.wav")
var settingsShowed = false

func _ready():
	$GameInfo/GameVersion.text = get_ver(gameVerFile)
	$CanvasLayer/Settings/Panel.visible = false
	$Buttons/StartButton.grab_focus()

func _process(delta):
	if Input.is_action_just_pressed("debug_pause"):
		if settingsShowed:
			showOptions(false)

func _on_StartButton_pressed():
	SceneTransition.change_scene("res://levels/test_level/TestLevel.tscn")

func _on_OptionsButton_pressed():
	if !settingsShowed:
		showOptions(true)
	else:
		showOptions(false)

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_CreditsButton_pressed():
	SceneTransition.change_scene("res://other_scenes/Credits.tscn")

func get_ver(file):
	var f = File.new()
	f.open(file, File.READ)
	var ver = f.get_line()
	f.close()
	return ver

func showOptions(show: bool):
	if show:
		$CanvasLayer/Settings/Panel.visible = true
		$"CanvasLayer/Settings/Panel/TabContainer/Video And Audio/VBoxContainer/FullScreenBtn".grab_focus()
		settingsShowed = true
	else:
		$CanvasLayer/Settings/Panel.visible = false
		$Buttons/StartButton.grab_focus()
		settingsShowed = false
