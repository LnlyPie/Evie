extends Node2D

func _ready():
	$BackButton.grab_focus()
	
func _on_BackButton_pressed():
	SceneTransition.change_scene("res://other_scenes/MainMenu.tscn")
