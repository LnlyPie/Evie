extends Control

var slot = Save.slot_picked
var notempty

func _ready():
	$VBoxContainer/InfoContainer/LineEdit.grab_focus()

func _on_DoneButton_pressed():
	if ($VBoxContainer/InfoContainer/LineEdit.text != ""):
		Save.save_info["save_name"] = $VBoxContainer/InfoContainer/LineEdit.text
		notempty = true
	else:
		notempty = false
	if ($VBoxContainer/GameContainer/LineEdit.text != ""):
		Save.player_data["name"] = $VBoxContainer/GameContainer/LineEdit.text
		notempty = true
	else:
		notempty = false
	
	if (notempty):
		Save.new_save(slot)
		Save.get_chapter()

func _on_Back_pressed():
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")
