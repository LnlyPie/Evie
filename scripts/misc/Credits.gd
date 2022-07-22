extends Node2D

func _ready():
	$BackButton.grab_focus()
	
func _on_BackButton_pressed():
	get_tree().change_scene("res://other_scenes/MainMenu.tscn")
