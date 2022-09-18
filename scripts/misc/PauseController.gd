extends Node

export(bool) var can_toogle_pause: bool = true # Probably won't be needed
var paused: bool = false
var exitscreen: bool = false

var clockTimer = null

func _ready():
	var levelName = get_tree().get_current_scene().get_name().split("_", true, 1)
	var act = levelName[1].split("-", true, 1)
	var actNum = act[0]
	var actName = act[1].replace("*", " ")
	$Panel.visible = false
	$QuitPanel.visible = false
	$Panel/LevelName.text = levelName[0]
	$Panel/ActNumber.text = "Act " + actNum + ": " + actName
	clockTimerInit()

func _process(_delta):
	if Input.is_action_just_pressed("debug_pause"):
		if get_tree().paused:
			if Settings.settingsShowed:
				showSettings(false)
			else:
				Cursor.show_cursor(false)
				pause(false)
		else:
			Cursor.show_cursor(true)
			pause(true)

func pause(pause: bool):
	if can_toogle_pause:
		if pause:
			$Panel.visible = true
			$Panel/VBoxContainer/ResumeButton.grab_focus()
			get_tree().set_deferred("paused", true)
			paused = true
		else:
			$Panel.visible = false
			get_tree().set_deferred("paused", false)
			paused = false

func _on_ResumeButton_pressed():
	pause(false)

func _on_SettingsButton_pressed():
	if !Settings.settingsShowed:
		showSettings(true)
	else:
		showSettings(false)

func _on_QuitButton_pressed():
	if !exitscreen:
		$QuitPanel.visible = true
		$QuitPanel/PleaseDont.visible = false
		$QuitPanel/ButtonsContainer/MenuButton.grab_focus()
	else:
		$QuitPanel.visible = false
		$Panel/VBoxContainer/ResumeButton.grab_focus()

func _on_MenuButton_pressed():
	pause(false)
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_CancelButton_pressed():
	$QuitPanel.visible = false
	$Panel/VBoxContainer/ResumeButton.grab_focus()

func showSettings(show: bool):
	if show:
		$Settings/Panel.visible = true
		$"Settings/Panel/TabContainer/Video And Audio/VBoxContainer/FullScreenBtn".grab_focus()
		Settings.settingsShowed = true
	else:
		$Settings/Panel.visible = false
		$Panel/VBoxContainer/ResumeButton.grab_focus()
		Settings.settingsShowed = false

func clockTimerInit():
	clockTimer = Timer.new()
	add_child(clockTimer)
	clockTimer.connect("timeout", self, "_on_Timer_timeout")
	clockTimer.set_wait_time(1.0)
	clockTimer.set_one_shot(false)
	clockTimer.start()

func _on_Timer_timeout():
	$Panel/SystemTime.text = String(OS.get_time()["hour"]) + ":" + String(OS.get_time()["minute"]) + ":" + String(OS.get_time()["second"])


func _on_ExitButton_focus_entered():
	$QuitPanel/PleaseDont.visible = true


func _on_ExitButton_focus_exited():
	$QuitPanel/PleaseDont.visible = false


func _on_PhotoButton_pressed():
	pass
