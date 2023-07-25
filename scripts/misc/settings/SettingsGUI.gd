extends Node

signal settings_closed

func _ready() -> void:
	if Settings.fullscreen:
		$Panel/Settings/VideoSettings/Center/FullscreenCheckButton.pressed = true
	$Panel/Settings/VideoSettings/Resolutions/FullHD.grab_focus()

# Screen Settings
func _on_1920_pressed() -> void:
	Settings.screen_width = 1920
	Settings.screen_height = 1080

func _on_1366_pressed() -> void:
	Settings.screen_width = 1366
	Settings.screen_height = 768

func _on_1280_pressed() -> void:
	Settings.screen_width = 1280
	Settings.screen_height = 1024

func _on_1024_pressed() -> void:
	Settings.screen_width = 1024
	Settings.screen_height = 768

func _on_FullscreenCheckButton_toggled(button_pressed: bool) -> void:
	Settings.fullscreen = button_pressed

# Color Filters
func _on_ColorsOff_pressed():
	Settings.color1 = 0
	Settings.color2 = 0
func _on_Protanopia_pressed():
	Settings.color1 = 3
	Settings.color2 = 0
func _on_Deuteranopia_pressed():
	Settings.color1 = 3
	Settings.color2 = 1
func _on_Tritanopia_pressed():
	Settings.color1 = 3
	Settings.color2 = 2
func _on_Retro_pressed():
	Settings.color1 = 1
	Settings.color2 = 0
func _on_Grayscale_pressed():
	Settings.color1 = 2
	Settings.color2 = 0

# Languages
func _on_English_pressed() -> void:
	Settings.language = "en"

func _on_Polish_pressed() -> void:
	Settings.language = "pl"

func _on_German_pressed() -> void:
	Settings.language = "de"

# Exit Buttons
func _on_SaveExitButton_pressed() -> void:
	Settings.save()
	Settings.load()
	Settings.apply()
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")

func _on_ExitButton_pressed() -> void:
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")
