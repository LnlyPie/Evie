extends Control

func _ready():
	$"Panel/Chapters/Test Level/PlayButton".grab_focus()

func _on_TestLevel_PlayButton_pressed():
	SceneTransition.change_scene("res://levels/test_level/TestLevel.tscn")
