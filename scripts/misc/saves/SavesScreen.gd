extends Control

var savedel = 1

func _ready():
	$Panel/Saves/SaveSlot1.grab_focus()
	for num in range(1, 4):
		var save = Save.get_save_info(num)
		var save_split = save.split("*", true, 2)
		set_save_info(num)

func set_save_info(num: int):
	var save = Save.get_save_info(num)
	var save_split = save.split("*", true, 2)
	
	var save_node = get_node("Panel").get_node("Saves").get_node("SaveSlot" + str(num))
	
	save_node.get_node("SaveName").text = save_split[0] + " (" + Save.get_character_name(num) + ")"
	save_node.get_node("SaveDates").get_node("Created").text = "Created: " + save_split[1]
	if (!save_split[2] == "-"):
		save_node.get_node("SaveDates").get_node("Saved").text = "Last Saved: " + Utils.readable_timedate(save_split[2])
	else:
		save_node.get_node("SaveDates").get_node("Saved").text = "Last Saved: " + save_split[2]

func _on_SaveSlot1_pressed():
	save_load(1)

func _on_SaveSlot2_pressed():
	save_load(2)

func _on_SaveSlot3_pressed():
	save_load(3)

func _on_Back_pressed():
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")


func save_load(slot: int):
	if Save.exists(slot):
		Save.load_data(slot)
		Save.get_chapter()
	else:
		Save.slot_picked = slot
		SceneTransition.change_scene("res://scenes/saves/SaveCreator.tscn")

func _on_Delete1_pressed():
	$ConfirmationDialog.popup()
	savedel = 1

func _on_Delete2_pressed():
	$ConfirmationDialog.popup()
	savedel = 2

func _on_Delete3_pressed():
	$ConfirmationDialog.popup()
	savedel = 3

func _on_ConfirmationDialog_confirmed():
	Save.delete_save(savedel)
	SceneTransition.change_scene("res://scenes/saves/Saves.tscn")
