extends Control

onready var gameVerFile = "res://version.txt"
var blockedSound = preload("res://sounds/gui/blocked.wav")

func _ready():
	auth()
	$GameInfo/GameVersion.text = get_ver(gameVerFile)
	$CanvasLayer/Settings/Panel.visible = false
	$Buttons/StartButton.grab_focus()

func _process(_delta):
	if Input.is_action_just_pressed("debug_pause"):
		if Settings.settingsShowed:
			showSettings(false)

func _on_StartButton_pressed():
	Cursor.show_cursor(false)
	SceneTransition.change_scene("res://levels/test_level/TestLevel.tscn")

func _on_OptionsButton_pressed():
	if !Settings.settingsShowed:
		showSettings(true)
	else:
		showSettings(false)

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_CreditsButton_pressed():
	SceneTransition.change_scene("res://scenes/Credits.tscn")

func _on_GameJoltButton_pressed():
	SceneTransition.change_scene("res://scenes/GameJolt/GameJoltLogin.tscn")

func get_ver(file):
	var f = File.new()
	f.open(file, File.READ)
	var ver = f.get_line()
	f.close()
	return ver

func showSettings(show: bool):
	if show:
		$CanvasLayer/Settings/Panel.visible = true
		$"CanvasLayer/Settings/Panel/TabContainer/Video And Audio/VBoxContainer/FullScreenBtn".grab_focus()
		Settings.settingsShowed = true
	else:
		$CanvasLayer/Settings/Panel.visible = false
		$Buttons/StartButton.grab_focus()
		Settings.settingsShowed = false

func auth():
	Auth.set_game_creds()
	Auth.try_autologin()
	if GameJoltAPI.username != null:
		var sign_in_trophy = GameJoltAPI.add_achieved({
			"username": GameJoltAPI.username,
			"user_token": GameJoltAPI.user_token,
			"trophy_id": "158932"
		})
