extends Node

export(bool) var can_toogle_pause: bool = true # Probably won't be needed
var paused: bool = false

export(int) var actNum: int = 0
export(String) var actName: String = "Some Act"

func _ready():
	$Panel.visible = false
	$Panel/LevelName.text = get_tree().get_current_scene().get_name()
	$Panel/ActNumber.text = "Act " + str(actNum) + ": " + actName

func _process(delta):
	if Input.is_action_just_pressed("debug_pause"):
		if !get_tree().paused:
			pause(false)
		else:
			pause(true)

func pause(isPaused: bool):
	if can_toogle_pause:
		if !isPaused:
			$Panel.visible = true
			$Panel/VBoxContainer/ResumeButton.grab_focus()
			get_tree().set_deferred("paused", true)
			paused = true
		else:
			$Panel.visible = false
			get_tree().set_deferred("paused", false)
			paused = false

func _on_ResumeButton_pressed():
	pause(true)

func _on_SettingsButton_pressed():
	pass

func _on_MainMenuButton_pressed():
	pause(true)
	SceneTransition.change_scene("res://other_scenes/MainMenu.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
