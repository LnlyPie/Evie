extends Control

func _ready():
	for num in range(1, 4):
		var save = Save.get_save_info(num)
		var save_split = save.split("*", true, 2)
		set_save_info(num)

func set_save_info(num: int):
	var save = Save.get_save_info(num)
	var save_split = save.split("*", true, 2)
	get_node("Panel").get_node("Saves").get_node("SaveSlot" + str(num)).get_node("SaveName").text = save_split[0] + " (" + Save.get_character_name(1) + ")"
	get_node("Panel").get_node("Saves").get_node("SaveSlot" + str(num)).get_node("SaveDates").get_node("Created").text = "Created: " + save_split[1]
	if (!save_split[2] == "-"):
		get_node("Panel").get_node("Saves").get_node("SaveSlot" + str(num)).get_node("SaveDates").get_node("Saved").text = "Last Saved: " + Utils.readable_timedate(save_split[2])
	else:
		get_node("Panel").get_node("Saves").get_node("SaveSlot" + str(num)).get_node("SaveDates").get_node("Saved").text = "Last Saved: " + save_split[2]
