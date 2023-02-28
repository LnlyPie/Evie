extends Node

var slot_picked:int = 0
var player_data = {
	"name": "Evie",
	"health": 5,
	"inventory": [],
	"last_location": "",
	"quests_completed": []
}
var save_info = {
	"save_name": "Evie",
	"save_creation": Utils.get_date_and_time(1),
	"last_saved": Utils.get_date_and_time()
}

func save_data(slot):
	var file = File.new()
	var dir = Directory.new()
	var cfg = ConfigFile.new()
	if !dir.dir_exists(Utils.savesFolder + "save" + str(slot)):
		dir.make_dir(Utils.savesFolder + "save" + str(slot))
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

func load_data(slot):
	var file = File.new()
	var cfg = ConfigFile.new()
	if file.file_exists(Utils.savesFolder + "save" + str(slot) + "/save.dat"):
		file.open(Utils.savesFolder + "save" + str(slot) + "/save.dat", File.READ)
		var json = file.get_as_text()
		player_data = JSON.parse(json).result
		file.close()
	if file.file_exists(Utils.savesFolder + "save" + str(slot) + "/save.cfg"):
		cfg.load(Utils.savesFolder + "save" + str(slot) + "/save.cfg")
		save_info["save_name"] = cfg.get_value("Info", "name")
		save_info["save_creation"] = cfg.get_value("Info", "created")
		save_info["last_saved"] = cfg.get_value("Info", "last_saved")

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
