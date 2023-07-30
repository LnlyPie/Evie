extends Control

var slot = Save.slot_picked
var notempty

func _ready():
	$VBoxContainer/InfoContainer/LineEdit.grab_focus()

func _on_DoneButton_pressed():
	if ($VBoxContainer/InfoContainer/LineEdit.text != ""):
		Save.save_info["save_name"] = $VBoxContainer/GameContainer/LineEdit.text
		notempty = true
	else:
		notempty = false
	if ($VBoxContainer/GameContainer/LineEdit.text != ""):
		Save.player_data["name"] = $VBoxContainer/GameContainer/LineEdit.text
		notempty = true
	else:
		notempty = false
	
	if (notempty):
		Save.save_data(slot)
		Save.get_chapter()
