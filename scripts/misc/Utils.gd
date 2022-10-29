extends Node

var dir = Directory.new()

var photosFolder = "user://screenshots/"
var settingsFolder = "user://settings/"
var modsFolder = "user://mods/"

func _ready():
	if !dir.file_exists(photosFolder):
		dir.make_dir(photosFolder)
	if !dir.file_exists(settingsFolder):
		dir.make_dir(settingsFolder)
	if !dir.file_exists(modsFolder):
		dir.make_dir(modsFolder)

func screenshot():
	var image = get_viewport().get_texture().get_data()
	image.flip_y()
	image.save_png(photosFolder + "screenshot-" + getDateAndTime() + ".png")

func getDateAndTime():
	# Get Time and Date
	var systemDate = OS.get_date()
	var systemTime = OS.get_time()
	# Translate it to anything readable (ex. 2022-07-12_12:58:12)
	var date_return = String(systemDate.year) + "-" + String(systemDate.month) + "-" + String(systemDate.day)
	var time_return = String(systemTime.hour) + ":" + String(systemTime.minute) + ":" + String(systemTime.second)
	# Return it
	var date_and_time = date_return + "_" + time_return
	return date_and_time

func showDialogue(dialogueFile: String, dialogueNode: String):
	var file = load(dialogueFile)
	DialogueManager.show_example_dialogue_balloon(\
		dialogueNode, \
		file
	)

func load_file(file_path):
	var file = File.new()
	file.open(file_path, file.READ)
	var text = file.get_as_text()
	return text

func get_random_word_from_file(file_path):
	var text = load_file(file_path).strip_edges()
	var words = text.split("|")
	for i in range(words.size()):
		words[i] = words[i].replace("|", "")
	return words[randi() % words.size()]

func give_trophy(id: String):
	if Mod.isModded:
		if Mod.enableGameJolt:
			if !GameJoltAPI.username == "":
				var trophy = GameJoltAPI.add_achieved({
					"username": GameJoltAPI.username,
					"user_token": GameJoltAPI.user_token,
					"trophy_id": id
				})
	else:
		if !GameJoltAPI.username == "":
			var trophy = GameJoltAPI.add_achieved({
					"username": GameJoltAPI.username,
					"user_token": GameJoltAPI.user_token,
					"trophy_id": id
				})

func checkIfModded():
	if Mod.isModded:
		get_tree().get_root().get_node("MainMenu").get_node("ModInfo")\
		.get_node("ModName").text = Mod.modName
		get_tree().get_root().get_node("MainMenu").get_node("ModInfo")\
		.get_node("ModVersion").text = Mod.modVersion
		get_tree().get_root().get_node("MainMenu").get_node("CreditsContainer")\
		.get_node("ModCredit").text = Mod.modAuthor
	else:
		get_tree().get_root().get_node("MainMenu").get_node("ModInfo")\
		.get_node("ModName").visible = false
		get_tree().get_root().get_node("MainMenu").get_node("ModInfo")\
		.get_node("ModVersion").visible = false
		get_tree().get_root().get_node("MainMenu").get_node("CreditsContainer")\
		.get_node("ModCredit").visible = false
