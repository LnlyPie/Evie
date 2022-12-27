extends Node

func apply_mod(mod_dir):
	var file = File.new()
	var mod = mod_dir + "/Mod.pck"
	if file.file_exists(Utils.modsFolder + mod):
		var success = ProjectSettings.load_resource_pack(Utils.modsFolder + mod)
		if success:
			SceneTransition.change_scene("res://Mod.tscn")
		else:
			printerr("Could not load mod: " + mod)
