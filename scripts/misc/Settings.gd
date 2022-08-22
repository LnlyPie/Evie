extends Node

var settingsShowed = false

func _on_FullScreenBtn_toggled(button_pressed):
	if button_pressed:
		fullscreen(true)
	else:
		fullscreen(false)
		
func fullscreen(full: bool):
	if full:
		OS.window_fullscreen = true
	else:
		OS.window_fullscreen = false
