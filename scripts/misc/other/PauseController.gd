extends Node

export(bool) var can_toogle_pause: bool = true # Probably won't be needed
var paused: bool = false
var exitscreen: bool = false

var date = OS.get_date()
var time = OS.get_time()
var clockTimer = null

func _ready():
	# Set Chapter Info
	chapterInfo()
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
		# Change visibility
		$Panel.visible = true
		$Panel/Buttons/ResumeButton.grab_focus()
		# Get Active Quests
		_get_quests()
		# Show Panel
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
	Save.save_data(Save.slot_picked)
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")

func _on_ExitButton_pressed():
	Save.save_data(Save.slot_picked)
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

func chapterInfo():
	# Get Chapter and Act
	var scene = get_tree().get_current_scene().get_name()
	var level = scene.split("_", true, 1)
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

func _get_quests():
	$Panel/ActiveQuests/QuestsPanel/QuestsList.clear()
	var questInt:int = 0
	for quest in Quests.quests:
		if Quests.quests[quest]["completed"] == false:
			$Panel/ActiveQuests/QuestsPanel/QuestsList.add_item(quest + " - " \
			 + Quests.get_progress_now_max(quest))
			$Panel/ActiveQuests/QuestsPanel/QuestsList.set_item_tooltip(questInt, Quests.get_desc(quest))
			questInt += 1

func _on_Timer_timeout():
	$Panel/DateTime/Time/TimeLabel.text = String(OS.get_time()["hour"]) + ":" \
	+ String(OS.get_time()["minute"])

func _on_ExitButton_focus_entered():
	$QuitPanel/PleaseDont.visible = true

func _on_ExitButton_focus_exited():
	$QuitPanel/PleaseDont.visible = false
