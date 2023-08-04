extends Node

func upload_saves():
	var num_saves = 3
	for save_index in range(1, num_saves + 1):
		var save_folder = "save" + str(save_index)
		
		var dat_file = Utils.savesFolder + save_folder + "/save.dat"
		var cfg_file = Utils.savesFolder + save_folder + "/save.cfg"
		var ach_file = Utils.savesFolder + save_folder + "/achievements.json"
		
		if File.new().file_exists(dat_file) and File.new().file_exists(cfg_file) and File.new().file_exists(ach_file):
			var save_dat = yield(Firebase.Storage.ref("users/" + Firebase.Auth.auth["localid"] + "/games/evie/saves/" + save_folder + "/save.dat").put_file(dat_file), "task_finished")
			var save_cfg = Firebase.Storage.ref("users/" + Firebase.Auth.auth["localid"] + "/games/evie/saves/" + save_folder + "/save.cfg").put_file(cfg_file)
			var save_ach = Firebase.Storage.ref("users/" + Firebase.Auth.auth["localid"] + "/games/evie/saves/" + save_folder + "/achievements.json").put_file(ach_file)
		else:
			print("Save " + str(save_index) + " doesn't exist! It will not be saved to the cloud.")

func download_saves():
	pass
	var num_saves = 3
	for save_index in range(1, num_saves + 1):
		var save_folder = "save" + str(save_index)

		var dat_file = Firebase.Storage.ref("users/" + Firebase.Auth.auth["localid"] + "/games/evie/saves/" + save_folder + "/save.dat").get_data()
		var dat_result = yield(task_to_save(dat_file, save_folder), "completed")
		var cfg_file = Firebase.Storage.ref("users/" + Firebase.Auth.auth["localid"] + "/games/evie/saves/" + save_folder + "/save.cfg").get_data()
		var cfg_result = yield(task_to_save(cfg_file, save_folder), "completed")
		var ach_file = Firebase.Storage.ref("users/" + Firebase.Auth.auth["localid"] + "/games/evie/saves/" + save_folder + "/achievements.json").get_data()
		var ach_result = yield(task_to_save(ach_file, save_folder), "completed")
		if (dat_result != "error" || cfg_result != "error" || ach_result != "error"):
			Save.download_save(save_folder, dat_result, cfg_result, ach_result)

func task_to_save(task: StorageTask, sav) -> String:
	var text_content: String = ""
	yield(task, "task_finished")
	match typeof(task.data):
		TYPE_RAW_ARRAY:
			var data: PoolByteArray = task.data
			if data.size() > 0:
				text_content = data.get_string_from_ascii()
		TYPE_DICTIONARY:
			print("ERROR " + str(task.data.error.code) + ": could not find text content requested (" + sav + ")")
			text_content = "error"
	return text_content
