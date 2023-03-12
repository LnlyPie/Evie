extends Node

var file = File.new()
var dir = Directory.new()
var cfg = ConfigFile.new()

var mods_loaded = []

# Only loads the mod
func load_mod(mod_dir):
	var mod = Utils.modsFolder + mod_dir + "/Mod.pck"
	var modinfo = Utils.modsFolder + mod_dir + "/Mod.cfg"
	if file.file_exists(mod) and file.file_exists(modinfo):
		var success = ProjectSettings.load_resource_pack(mod)
		if success:
			cfg.load(modinfo)
			ModVars.modName = cfg.get_value("ModInfo", "name")
			ModVars.modVersion = cfg.get_value("ModInfo", "version")
			ModVars.modAuthor = cfg.get_value("ModInfo", "author")
			mods_loaded.append(ModVars.modName + "/" + ModVars.modAuthor)
		else:
			printerr("Could not load mod: " + mod)

# Loads the mod AND runs yourmodname.gd
# The mod name is from Mod.cfg file
func apply_mod(mod_dir):
	load_mod(mod_dir)
	var mod_script = load("res://" + ModVars.modName + ".gd")
	_load_mod_script(mod_script)

func _ready():
	dir.open(Utils.modsFolder)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			if file.begins_with("LOAD_"):
				load_mod(file)

func apply_check():
	dir.open(Utils.modsFolder)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			if file.begins_with("APPLY_"):
				apply_mod(file)

func _load_mod_script(mod_script):
	var script_instance = mod_script.new()
	get_node("/root").add_child(script_instance)
