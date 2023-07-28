extends Control

# To be optimized later
func _ready():
	var save1 = Save.get_save_info(1)
	var save1_split = save1.split("*", true, 2)
	$Panel/Saves/SaveSlot1/SaveName.text = save1_split[0] + " (" + Save.get_character_name(1) + ")"
	$Panel/Saves/SaveSlot1/SaveDates/Created.text = "Created: " + save1_split[1]
	if (!save1_split[2] == "-"):
		$Panel/Saves/SaveSlot1/SaveDates/Saved.text = "Last Saved: " + Utils.readable_timedate(save1_split[2])
	else:
		$Panel/Saves/SaveSlot1/SaveDates/Saved.text = "Last Saved: " + save1_split[2]
	
	var save2 = Save.get_save_info(2)
	var save2_split = save2.split("*", true, 2)
	$Panel/Saves/SaveSlot2/SaveName.text = save2_split[0] + " (" + Save.get_character_name(1) + ")"
	$Panel/Saves/SaveSlot2/SaveDates/Created.text = "Created: " + save2_split[1]
	if (!save2_split[2] == "-"):
		$Panel/Saves/SaveSlot2/SaveDates/Saved.text = "Last Saved: " + Utils.readable_timedate(save2_split[2])
	else:
		$Panel/Saves/SaveSlot2/SaveDates/Saved.text = "Last Saved: " + save2_split[2]
	
	var save3 = Save.get_save_info(3)
	var save3_split = save3.split("*", true, 2)
	$Panel/Saves/SaveSlot3/SaveName.text = save3_split[0] + " (" + Save.get_character_name(3) + ")"
	$Panel/Saves/SaveSlot3/SaveDates/Created.text = "Created: " + save3_split[1]
	if (!save3_split[2] == "-"):
		$Panel/Saves/SaveSlot3/SaveDates/Saved.text = "Last Saved: " + Utils.readable_timedate(save3_split[2])
	else:
		$Panel/Saves/SaveSlot3/SaveDates/Saved.text = "Last Saved: " + save3_split[2]
