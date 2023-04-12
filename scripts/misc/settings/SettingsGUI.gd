extends Node

var shown = false
signal settings_closed

func _ready() -> void:
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

func _on_English_pressed() -> void:
	Settings.language = "en"

func _on_Polish_pressed() -> void:
	Settings.language = "pl"

func _on_German_pressed() -> void:
	Settings.language = "de"

func _on_SaveExitButton_pressed() -> void:
	Settings.save()
	Settings.load()
	toggle()

func _on_ExitButton_pressed() -> void:
	toggle()

func toggle():
	if !shown:
		shown = true
		$Panel.visible = true
		$AnimationPlayer.play("onload")
		$Panel/Settings/VideoSettings/Resoultions/FullHD.grab_focus()
	else:
		shown = false
		$AnimationPlayer.play_backwards("onload")
		yield(get_tree().create_timer(1), "timeout")
		$Panel.visible = false
		emit_signal("settings_closed")
