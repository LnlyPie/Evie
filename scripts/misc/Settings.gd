extends Node

var settingsShowed = false

var fullscreen = false

func _on_FullScreenBtn_toggled(button_pressed):
	if button_pressed:
		fullscreen(true)
	else:
		fullscreen(false)
		
func fullscreen(full: bool):
	if full:
		OS.window_fullscreen = true
		fullscreen = true
	else:
		OS.window_fullscreen = false
		fullscreen = false

func _on_LangButton_item_selected(index):
	if index == 0:
		TranslationServer.set_locale("en")
	if index == 1:
		TranslationServer.set_locale("pl")
