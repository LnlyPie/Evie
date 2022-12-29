extends Control

func _ready():
	_list_mods()

func _list_mods():
	var files = []
	var dir = Directory.new()
	var cfg = ConfigFile.new()
	dir.open(Utils.modsFolder)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			dir.open(Utils.modsFolder + file + "/")
			var modinfo = Utils.modsFolder + file + "/Mod.cfg"
			if dir.file_exists(modinfo):
				cfg.load(modinfo)
				$ItemList.add_item(str(cfg.get_value("ModInfo", "name")) + " - " + \
				 str(cfg.get_value("ModInfo", "version")) + " - " + \
				 str(cfg.get_value("ModInfo", "author")))
	dir.list_dir_end()
