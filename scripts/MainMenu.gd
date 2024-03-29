extends Control

onready var gameVerFile = "res://version.txt"
var blockedSound = preload("res://sounds/gui/blocked.wav")

func _ready():
	$MainButtons/StartButton.grab_focus()
	$BugHaters.visible = false
	$Splashes.text = splashtext()
	$GameInfo/GameVersion.text = get_ver(gameVerFile)
	if Utils.isHtml():
		$MainButtons/QuitButton.hide()
	_list_mods()

func _on_StartButton_pressed():
	SceneTransition.change_scene("res://scenes/saves/Saves.tscn")

func _on_OptionsButton_pressed():
	SceneTransition.change_scene("res://scenes/settings/Settings.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_ModsButton_pressed():
	SceneTransition.change_scene("res://scenes/misc/mods/ModSelector.tscn")

func _on_CreditsButton_pressed():
	SceneTransition.change_scene("res://scenes/Credits.tscn")

func _on_GithubButton_pressed():
	OS.shell_open("https://github.com/lnlypie/evie")

func _on_BugsButton_pressed():
	OS.shell_open("https://github.com/lnlypie/evie/issues")

func _on_WebsiteButton_pressed():
	OS.shell_open("https://lonelypie.net/")

func get_ver(file):
	var f = File.new()
	f.open(file, File.READ)
	var ver = f.get_line()
	f.close()
	return ver

func splashtext():
	var random_splash = Utils.get_random_word_from_file("res://splashes.txt")
	return random_splash

func _on_SplashCheatCode_cheat_activated():
	$Splashes.text = "The cake is a lie"

func _on_BugsButton_focus_entered() -> void:
	$BugHaters.visible = true

func _on_BugsButton_focus_exited() -> void:
	$BugHaters.visible = false

func _list_mods():
	var modid = 0

	if !ModLoader.mods_loaded.empty():
		while true:
			if modid >= ModLoader.mods_loaded.size():
				break
			else:
				var mod = ModLoader.mods_loaded[modid]
				$ModList.add_item(mod)
				modid += 1
		$ModList.visible = true
	else:
		$ModList.visible = false

func _on_AccountButton_pressed():
	SceneTransition.change_scene("res://scenes/account/Account.tscn")
