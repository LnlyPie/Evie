extends Node

export(bool) var can_toogle_pause: bool = true # Probably won't be needed
var paused: bool = false
var exitscreen: bool = false

var date = OS.get_date()
var time = OS.get_time()
var clockTimer = null

func _ready():
	# Get Chapter and Act
	var level = get_tree().get_current_scene().get_name().split("_", true, 1)
	var levelN = level[0].split("-", true, 1)
	var levelNum = levelN[0].replace("*", " ")
	var levelName = levelN[1].replace("*", " ")
	var act = level[1].split("-", true, 1)
	var actNum = act[0]
	var actName = act[1].replace("*", " ")
	# Set Chapter Name
	$Panel.visible = false
	$QuitPanel.visible = false
	$Panel/LevelInfoContainer/LevelName.text = levelNum + ": " + levelName
	$Panel/LevelInfoContainer/ActNumber.text = "Act " + actNum + ": " + actName
	# Set Date & Time
	$Panel/DateTime/Date/DateLabel.text = String(date["day"]) + "." \
	+ String(date["month"]) + "." + String(date["year"])
	clockTimerInit()

func _process(_delta):
	if Input.is_action_just_pressed("debug_pause") || Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused:
			if $QuitPanel.visible == false:
				Cursor.show_cursor(false)
				pause(false)
			else:
				$AnimationPlayer.play_backwards("exit")
				yield(get_tree().create_timer(1), "timeout")
				$QuitPanel.visible = false
				$Panel/Buttons/ResumeButton.grab_focus()
	if Input.is_action_just_pressed("debug_pause"):
		if !get_tree().paused:
			Cursor.show_cursor(true)
			pause(true)

func pause(pause: bool):
	if pause:
		$Panel.visible = true
		$Panel/Buttons/ResumeButton.grab_focus()
		get_tree().set_deferred("paused", true)
		paused = true
		$AnimationPlayer.play("onload")
	else:
		$AnimationPlayer.play_backwards("onload")
		yield(get_tree().create_timer(0.5), "timeout")
		$Panel.visible = false
		get_tree().set_deferred("paused", false)
		paused = false

func _on_ResumeButton_pressed():
	pause(false)

func _on_SettingsButton_pressed():
	pass

func _on_QuitButton_pressed():
	if !exitscreen:
		$QuitPanel.visible = true
		$QuitPanel/PleaseDont.visible = false
		$QuitPanel/ButtonsContainer/MenuButton.grab_focus()
		$AnimationPlayer.play("exit")
	else:
		$QuitPanel.visible = false
		$Panel/Buttons/ResumeButton.grab_focus()

func _on_MenuButton_pressed():
	pause(false)
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_CancelButton_pressed():
	$AnimationPlayer.play_backwards("exit")
	yield(get_tree().create_timer(1), "timeout")
	$QuitPanel.visible = false
	$Panel/Buttons/ResumeButton.grab_focus()

func clockTimerInit():
	clockTimer = Timer.new()
	add_child(clockTimer)
	clockTimer.connect("timeout", self, "_on_Timer_timeout")
	clockTimer.set_wait_time(1.0)
	clockTimer.set_one_shot(false)
	clockTimer.start()

func _on_Timer_timeout():
	$Panel/DateTime/Time/TimeLabel.text = String(OS.get_time()["hour"]) + ":" \
	+ String(OS.get_time()["minute"]) + ":" + String(OS.get_time()["second"])

func _on_ExitButton_focus_entered():
	$QuitPanel/PleaseDont.visible = true

func _on_ExitButton_focus_exited():
	$QuitPanel/PleaseDont.visible = false

func _on_PhotoButton_pressed():
	pass
