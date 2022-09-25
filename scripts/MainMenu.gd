extends Control

onready var gameVerFile = "res://version.txt"
var blockedSound = preload("res://sounds/gui/blocked.wav")

func _ready():
	auth()
	if GameJoltAPI.username == "":
		$GJAcc.text = "GameJolt:\nnot connected"
	else:
		$GJAcc.text = "GameJolt:\n" + GameJoltAPI.username
	$Splashes.text = splashtext()
	$GameInfo/GameVersion.text = get_ver(gameVerFile)
	ifHTML()
	$CanvasLayer/Settings/Panel.visible = false
	$Buttons/StartButton.grab_focus()

func _process(_delta):
	if Input.is_action_just_pressed("debug_pause") or Input.is_action_just_pressed("ui_cancel"):
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

func _on_GithubButton_pressed():
	OS.shell_open("https://github.com/lnlypie/evie")

func _on_BugsButton_pressed():
	OS.shell_open("https://github.com/lnlypie/evie/issues")

func _on_WebsiteButton_pressed():
	OS.shell_open("https://lpie.andus.dev/")

func get_ver(file):
	var f = File.new()
	f.open(file, File.READ)
	var ver = f.get_line()
	f.close()
	return ver

func showSettings(show: bool):
	if show:
		getLangs()
		$CanvasLayer/Settings/Panel.visible = true
		$"CanvasLayer/Settings/Panel/VAA/FullScreenBtn".grab_focus()
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

func getLangs():
	if !$CanvasLayer/Settings/Panel/Other/LangButton.get_item_id(1):
		$CanvasLayer/Settings/Panel/Other/LangButton.add_item("English", 1)
		$CanvasLayer/Settings/Panel/Other/LangButton.add_item("Polski", 2)
		$CanvasLayer/Settings/Panel/Other/LangButton.add_item("Deutsch", 3)

func splashtext():
	var random_splash = Utils.get_random_word_from_file("res://splashes.txt")
	return random_splash

func _on_SplashCheatCode_cheat_activated():
	$Splashes.text = "The cake is a lie"
	$Splash/Sprite.visible = true

func ifHTML():
	var os = OS.get_name()
	if os == "HTML5":
		$Splashes.text = "So you're a web gamer huh?"
		$GameInfo/GameVersion.text = "v. Always latest B)"
