extends Control

func _ready():
	var save1 = Save.get_save_info(1)
	var save1_split = save1.split("*", true, 2)
	$Panel/Saves/SaveSlot1/SaveName.text = save1_split[0]
