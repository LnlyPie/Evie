extends Node

func _ready() -> void:
	$AnimationPlayer.play("onload")
	if Settings.fullscreen:
		$Panel/Settings/VideoSettings/FullscreenCheckButton.pressed = true
	$Panel/Settings/VideoSettings/Resoultions/FullHD.grab_focus()

func _on_FullHD_pressed() -> void:
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

func _on_English_pressed() -> void:
	Settings.language = "en"

func _on_Polish_pressed() -> void:
	Settings.language = "pl"

func _on_German_pressed() -> void:
	Settings.language = "de"

func _on_SaveExitButton_pressed() -> void:
	Settings.save()
	Settings.load()

func _on_ExitButton_pressed() -> void:
	get_parent().remove_child(Settings)
