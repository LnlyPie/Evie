extends Node2D

func _ready():
	$Panel/VBoxContainer/GJName.grab_focus()

func _on_BackButton_pressed() -> void:
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")

func _on_LoginButton_pressed() -> void:
	GameJoltAPI.username = $Panel/VBoxContainer/GJName.text
	GameJoltAPI.user_token = $Panel/VBoxContainer/GJToken.text
