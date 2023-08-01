extends Control

func _ready():
	$BackButton.grab_focus()
	$AnimationPlayer.play("roll")
	yield($AnimationPlayer, "animation_finished")
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")
	
func _on_BackButton_pressed():
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")
