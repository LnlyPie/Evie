extends Control

func _ready():
	$AnimationPlayer.play("onload")
	$Panel/VBoxContainer/GJName.grab_focus()

func _on_BackButton_pressed():
	$AnimationPlayer.play_backwards("onload")
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")

func _on_LoginButton_pressed():
	Auth.login($Panel/VBoxContainer/GJName.text, $Panel/VBoxContainer/GJToken.text)
