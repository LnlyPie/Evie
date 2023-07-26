extends Node

var slot_picked:int = 1
const DEFAULT_PLAYER_DATA = {
	"name": "Evie",
	"health": 5,
	"inventory": [],
	"last_location": "",
	"chapter": 0,
	"quests_completed": []
}
var player_data = {
	"name": "Evie", # How NPCs refer to you in-game
	"health": 5,
	"inventory": [],
	"last_location": "",
	"chapter": 0, # -1 - test level, 0 - prologue etc.
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

func save_data(slot):
	var file = File.new()
	var dir = Directory.new()
	var cfg = ConfigFile.new()
	if !dir.dir_exists(Utils.savesFolder + "save" + str(slot)):
		dir.make_dir(Utils.savesFolder + "save" + str(slot))
	
	if save_info["save_creation"] == null:
		save_info["save_creation"] = Utils.get_date_and_time(1)
	save_info["last_saved"] = Utils.get_date_and_time()
	# Save save.dat
	file.open(Utils.savesFolder + "save" + str(slot) + "/save.dat", File.WRITE)
	var json = JSON.print(player_data)
	file.store_string(json)
	file.close()
	# Save save.cfg
	cfg.set_value("Info", "name", save_info["save_name"])
	cfg.set_value("Info", "created", save_info["save_creation"])
	cfg.set_value("Info", "last_saved", save_info["last_saved"])
	cfg.save(Utils.savesFolder + "save" + str(slot) + "/save.cfg")
	# Save achievements.json
	AchievementManager.save_achievements()

func load_data(slot):
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
		save_data(slot)
	# Load save.cfg
	if file.file_exists(Utils.savesFolder + "save" + str(slot) + "/save.cfg"):
		cfg.load(Utils.savesFolder + "save" + str(slot) + "/save.cfg")
		save_info["save_name"] = cfg.get_value("Info", "name")
		save_info["save_creation"] = cfg.get_value("Info", "created")
		save_info["last_saved"] = cfg.get_value("Info", "last_saved")
	# Load achievements.json
	AchievementManager.load_achievements()

func exists(slot, type = 0):
	var file = File.new()
	if type == 0:
		if file.file_exists(Utils.savesFolder + "save" + str(slot) + "/save.dat"):
			return true
	if type == 1:
		if file.file_exists(Utils.savesFolder + "save" + str(slot) + "/save.cfg"):
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
		return (cfg.get_value("Info", "name") + "-" + cfg.get_value("Info", "created") + "-" + cfg.get_value("Info", "last_saved"))
