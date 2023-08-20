extends Node

var slot_picked:int = 1
const DEFAULT_PLAYER_DATA = {
	"name": "Evie",
	"health": 5,
	"inventory": [],
	"last_location": "",
	"chapter": 0,
	"chapter_scene": 1,
	"quests_completed": []
}
var player_data = {
	"name": "Evie", # How NPCs refer to you in-game
	"health": 5,
	"inventory": [],
	"last_location": "",
	"chapter": 0, # 0 - prologue, 1 - chapter 1 etc.
	"chapter_scene": 1,
	"quests_completed": []
}
var save_info = {
	"save_name": "Evie", # Name in saves menu (for recognition)
	"save_creation": null, # When save was created
	"last_saved": null # When save was last saved
}

func get_saves():
	var dir = Directory.new()
	var slots_saved = []
	dir.open(Utils.savesFolder)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		if file.begins_with("save"):
			var slotnum = file.replace("save", "")
			slots_saved.append(slotnum)
	return slots_saved

func new_save(slot):
	var file = File.new()
	var dir = Directory.new()
	var cfg = ConfigFile.new()
	if !dir.dir_exists(Utils.savesFolder + "save" + str(slot)):
		dir.make_dir(Utils.savesFolder + "save" + str(slot))
	save_info["save_creation"] = Utils.get_date_and_time(1)
	save_info["last_saved"] = Utils.get_date_and_time()
	# Save save.cfg
	cfg.set_value("Info", "name", save_info["save_name"])
	cfg.set_value("Info", "created", save_info["save_creation"])
	cfg.set_value("Info", "last_saved", save_info["last_saved"])
	cfg.save(Utils.savesFolder + "save" + str(slot) + "/save.cfg")
	# Save save.dat
	file.open(Utils.savesFolder + "save" + str(slot) + "/save.dat", File.WRITE)
	var json = JSON.print(DEFAULT_PLAYER_DATA)
	file.store_string(json)
	file.close()

func save_data(slot, data_only: bool = false):
	var file = File.new()
	var dir = Directory.new()
	var cfg = ConfigFile.new()
	if !dir.dir_exists(Utils.savesFolder + "save" + str(slot)):
		dir.make_dir(Utils.savesFolder + "save" + str(slot))
	
	if (!data_only):
		if save_info["save_creation"] == null:
			save_info["save_creation"] = Utils.get_date_and_time(1)
		save_info["last_saved"] = Utils.get_date_and_time()
		# Save save.cfg
		cfg.set_value("Info", "name", save_info["save_name"])
		cfg.set_value("Info", "created", save_info["save_creation"])
		cfg.set_value("Info", "last_saved", save_info["last_saved"])
		cfg.save(Utils.savesFolder + "save" + str(slot) + "/save.cfg")
	# Save save.dat
	player_data["inventory"] = Inv.get_items_from_array()
	file.open(Utils.savesFolder + "save" + str(slot) + "/save.dat", File.WRITE)
	var json = JSON.print(player_data)
	file.store_string(json)
	file.close()
	# Save achievements.json
	AchievementManager.save_achievements()

func load_data(slot):
	player_data = ""
	var file = File.new()
	var cfg = ConfigFile.new()
	# Load save.dat
	if file.file_exists(Utils.savesFolder + "save" + str(slot) + "/save.dat"):
		file.open(Utils.savesFolder + "save" + str(slot) + "/save.dat", File.READ)
		var json = file.get_as_text()
		player_data = JSON.parse(json).result
		file.close()
		# Check for any new data
		for key in DEFAULT_PLAYER_DATA.keys():
			if !player_data.has(key):
				player_data[key] = DEFAULT_PLAYER_DATA[key]
			save_data(slot, true)
		Inv.set_items_to_array(player_data["inventory"])
	# Load save.cfg
	if file.file_exists(Utils.savesFolder + "save" + str(slot) + "/save.cfg"):
		cfg.load(Utils.savesFolder + "save" + str(slot) + "/save.cfg")
		save_info["save_name"] = cfg.get_value("Info", "name")
		save_info["save_creation"] = cfg.get_value("Info", "created")
		save_info["last_saved"] = cfg.get_value("Info", "last_saved")
	# Load achievements.json
	AchievementManager.load_achievements()
	slot_picked = slot

func download_save(slot, dat, cfg, ach):
	var dir = Directory.new()
	var path = Utils.savesFolder + slot
	var file_dat = File.new()
	var file_cfg = File.new()
	var file_ach = File.new()
	dir.make_dir_recursive(path)
	
	file_dat.open(path + "/save.dat", File.WRITE)
	file_dat.store_string(dat)
	file_dat.close()
	file_cfg.open(path + "/save.cfg", File.WRITE)
	file_cfg.store_string(cfg)
	file_cfg.close()
	file_ach.open(path + "/achievements.json", File.WRITE)
	file_ach.store_string(ach)
	file_ach.close()

func exists(slot):
	var file = File.new()
	if file.file_exists(Utils.savesFolder + "save" + str(slot) + "/save.dat") && file.file_exists(Utils.savesFolder + "save" + str(slot) + "/save.cfg"):
		return true
	else:
		return false

func get_slot_folder():
	return (Utils.savesFolder + "save" + str(slot_picked) + "/")

# For use in Save Select menu
func get_save_info(slot: int):
	var file = File.new()
	var cfg = ConfigFile.new()
	
	if file.file_exists(Utils.savesFolder + "save" + str(slot) + "/save.cfg"):
		cfg.load(Utils.savesFolder + "save" + str(slot) + "/save.cfg")
		return (cfg.get_value("Info", "name") + "*" + cfg.get_value("Info", "created") + "*" + cfg.get_value("Info", "last_saved"))
	else:
		return ("None*-*-")

func get_character_name(slot: int):
	var file = File.new()
	if file.file_exists(Utils.savesFolder + "save" + str(slot) + "/save.dat"):
		file.open(Utils.savesFolder + "save" + str(slot) + "/save.dat", File.READ)
		var json = file.get_as_text()
		var json_data = JSON.parse(json).result
		file.close()
		
		if json_data.has("name"):
			return json_data["name"]
		else:
			return "Name not found"
	else:
		return "None"

func get_chapter():
	if (player_data["chapter"] == -1):
		if (player_data["chapter_scene"] == 1):
			SceneTransition.change_scene("res://levels/test_level/TestLevel.tscn", "Scale")
	if (player_data["chapter"] == 0):
		if (player_data["chapter_scene"] == 1):
			# SceneTransition.change_scene("res://levels/prologue/Prologue_1.tscn")
			SceneTransition.change_scene("res://levels/test_level/TestLevel.tscn", "Scale")

func set_chapter(chapter: int, scene: int):
	player_data["chapter"] = chapter
	player_data["chapter_scene"] = scene

func delete_save(slot: int):
	var savePath = Utils.savesFolder + "save" + str(slot)
	var dir = Directory.new()
	if dir.dir_exists(savePath):
		Utils.removeDirectoryWithFiles(savePath)
	else:
		print("Save slot ", slot, " doesn't exist.")
