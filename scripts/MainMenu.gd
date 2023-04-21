extends Control

onready var gameVerFile = "res://version.txt"
var blockedSound = preload("res://sounds/gui/blocked.wav")

func _ready():
	$MainButtons/StartButton.grab_focus()
	$BugHaters.visible = false
	$Splashes.text = splashtext()
	$GameInfo/GameVersion.text = get_ver(gameVerFile)
	$CanvasLayer/Settings/Panel.visible = false
#	_list_mods()

#	Notification.send_notification("Noti1", "Notification test 1", "quest")
#	Notification.send_notification("Noti2", "Notification test 2", "quest")

func _on_StartButton_pressed():
	SceneTransition.change_scene("res://scenes/ChapterSelect.tscn")

func _on_OptionsButton_pressed():
	SettingsGUI.toggle()

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_ModsButton_pressed():
	SceneTransition.change_scene("res://scenes/misc/mods/ModSelector.tscn")

func _on_CreditsButton_pressed():
	SceneTransition.change_scene("res://scenes/Credits.tscn")

func _on_GameJoltButton_pressed():
	SceneTransition.change_scene("res://scenes/GameJolt/GameJoltLogin.tscn")

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

#func _list_mods(): # For future versions
#	var modid = 0
#
#	if !ModLoader.mods_loaded.empty():
#		while true:
#			if ModLoader.mods_loaded.size() > modid:
#				break
#			else:
#				var mod = ModLoader.mods_loaded[modid]
#				$ModList.add_item(ModLoader.mods_loaded[modid])
#				modid += 1
