extends Node

var file = File.new()
var dir = Directory.new()
var cfg = ConfigFile.new()

# Loads the mod AND opens Mod.tscn scene
func apply_mod(mod_dir):
	load_mod(mod_dir)
	SceneTransition.change_scene("res://Mod.tscn")

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
			ModVars.isModded = true
		else:
			printerr("Could not load mod: " + mod)

func _ready():
	dir.open(Utils.modsFolder)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			# If there is a folder named "LOADONLY_modname"
			# It will be LOADED on start (will not open Mod.tscn scene)
			if file.begins_with("LOADONLY_"):
				load_mod(file)

func apply_check():
	dir.open(Utils.modsFolder)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			# If there is a folder named "APPLY_modname"
			# It will be LOADED and APPLIED on start (will open Mod.tscn scene)
			if file.begins_with("APPLY_"):
				apply_mod(file)
