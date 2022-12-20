extends Node

func _ready():
	var dir = Directory.new()
	dir.change_dir(Utils.modsFolder)
	var dir_list = dir.get_dir_list()
	
	for mod_dir in dir_list:
		apply_mod(mod_dir)
		
func apply_mod(mod_dir):
	var dir = Directory.new()
	dir.change_dir(Utils.modsFolder + mod_dir)
	
	var file_list = dir.get_file_list()
	
	for file in file_list:
		if file.ends_with(".json"):
			var mod_file = File.new()
			if mod_file.open(Utils.modsFolder + mod_dir + "/" + file, File.READ):
				var json_code = mod_file.get_as_text()
				mod_file.close()
				
				var mod_data = JSON.parse(json_code).result
				Utils.add_debug_command(mod_data["new_command"]["command"], mod_data["new_command"]["description"])
