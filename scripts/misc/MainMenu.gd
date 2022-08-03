extends Control

onready var gameVerFile = "res://version.txt"
var blockedSound = preload("res://sounds/gui/blocked.wav")

func _ready():
	$HBoxContainer/GameVersion.text = get_ver(gameVerFile)
	$VBoxContainer/StartButton.grab_focus()

func _on_StartButton_pressed():
	SceneTransition.change_scene("res://levels/test_level/TestLevel.tscn")

func _on_OptionsButton_pressed():
	#$CanvasLayer/VideoSettings.visible = true
	$AudioPlayer2D.stream = blockedSound
	$AudioPlayer2D.play()

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_CreditsButton_pressed():
	SceneTransition.change_scene("res://other_scenes/Credits.tscn")

func update_settings(settings: Dictionary) -> void:
	OS.window_fullscreen = settings.fullscreen
	get_tree().set_screen_stretch(
		SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, settings.resolution
	)
	OS.set_window_size(settings.resolution)
	OS.vsync_enabled = settings.vsync

func _on_VideoSettings_ApplyButton_pressed(settings) -> void:
	update_settings(settings)

func get_ver(file):
	var f = File.new()
	f.open(file, File.READ)
	var ver = f.get_line()
	f.close()
	return ver
