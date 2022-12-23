extends Control

onready var gameVerFile = "res://version.txt"
var blockedSound = preload("res://sounds/gui/blocked.wav")

func _ready():
	$MainButtons/StartButton.grab_focus()
	$BugHaters.visible = false
	auth()
	$Splashes.text = splashtext()
	$GameInfo/GameVersion.text = get_ver(gameVerFile)
	Utils.checkIfModded()
	$CanvasLayer/Settings/Panel.visible = false
	# Early Build trophy (will be there until the release of Prologue)
	Utils.give_trophy("179883")

func _on_StartButton_pressed():
	Cursor.show_cursor(false)
	SceneTransition.change_scene("res://levels/test_level/TestLevel.tscn")

func _on_OptionsButton_pressed():
	SettingsGUI.toggle()

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

func auth():
	Auth.set_game_creds()
	if GameJoltAPI.username == "":
		Auth.try_autologin()
	if GameJoltAPI.username != null:
		Utils.give_trophy("158932")
	if GameJoltAPI.username == "":
		$GameJoltContainer/GJAcc.text = "GameJolt:\nnot connected"
	else:
		$GameJoltContainer/GJAcc.text = "GameJolt:\n" + GameJoltAPI.username

func splashtext():
	var random_splash = Utils.get_random_word_from_file("res://splashes.txt")
	return random_splash

func _on_SplashCheatCode_cheat_activated():
	$Splashes.text = "The cake is a lie"

func _on_BugsButton_focus_entered() -> void:
	$BugHaters.visible = true

func _on_BugsButton_focus_exited() -> void:
	$BugHaters.visible = false

func _on_LoginWithGJ_pressed() -> void:
	SceneTransition.change_scene("res://scenes/GameJolt/GameJoltLogin.tscn")
