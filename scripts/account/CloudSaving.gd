extends Node

func upload_saves():
	var num_saves = 3
	for save_index in range(1, num_saves + 1):
		var save_folder = "save" + str(save_index)
		
		var dat_file = Utils.savesFolder + save_folder + "/save.dat"
		var cfg_file = Utils.savesFolder + save_folder + "/save.cfg"
		var ach_file = Utils.savesFolder + save_folder + "/achievements.json"
		
		if File.new().file_exists(dat_file) and File.new().file_exists(cfg_file) and File.new().file_exists(ach_file):
			var save_dat = Firebase.Storage.ref("users/" + Firebase.Auth.auth["localid"] + "/games/evie/saves/" + save_folder + "/save.dat").put_file(dat_file)
			var save_cfg = Firebase.Storage.ref("users/" + Firebase.Auth.auth["localid"] + "/games/evie/saves/" + save_folder + "/save.cfg").put_file(cfg_file)
			var save_ach = Firebase.Storage.ref("users/" + Firebase.Auth.auth["localid"] + "/games/evie/saves/" + save_folder + "/achievements.json").put_file(ach_file)
		else:
			print("Save " + str(save_index) + " doesn't exist! It will not be saved to the cloud.")

func download_saves():
	# To be made
	pass
