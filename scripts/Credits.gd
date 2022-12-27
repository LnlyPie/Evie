extends Control

func _ready():
	$BackButton.grab_focus()
	
func _on_BackButton_pressed():
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")
