extends Node

var file = File.new()
var cfg = ConfigFile.new()

func apply_mod(mod_dir):
	var mod = Utils.modsFolder + mod_dir + "/Mod.pck"
	var modinfo = Utils.modsFolder + mod_dir + "/Mod.cfg"
	if file.file_exists(mod) and file.file_exists(modinfo):
		var success = ProjectSettings.load_resource_pack(mod)
		if success:
			cfg.load(modinfo)
			ModVars.modName = cfg.get_value("ModInfo", "name")
			ModVars.modVersion = cfg.get_value("ModInfo", "version")
			ModVars.modAuthor = cfg.get_value("ModInfo", "author")
			ModVars.isModded = true
			SceneTransition.change_scene("res://Mod.tscn")
		else:
			printerr("Could not load mod: " + mod)
