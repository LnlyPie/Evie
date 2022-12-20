extends Node

var dir = Directory.new()
var file = File.new()

var photosFolder = "user://screenshots/"
var settingsFolder = "user://settings/"
var modsFolder = "user://mods/"

var settingsFile = "user://settings/settings.cfg"

func checkFiles():
	# Create directories
	if !dir.file_exists(photosFolder):
		dir.make_dir(photosFolder)
	if !dir.file_exists(settingsFolder):
		dir.make_dir(settingsFolder)
	if !dir.file_exists(modsFolder):
		dir.make_dir(modsFolder)
	# Create files
	if !file.file_exists(settingsFile):
		Settings.save()

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

func send_notification(title, desc, icon):
	Notification.send_notification(title, desc, icon)

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
			give_trophy_ext(id)
	else:
		give_trophy_ext(id)

func give_trophy_ext(id: String):
	if !GameJoltAPI.username == "":
		var fetch_achieved = GameJoltAPI.fetch_trophy({
			"username": GameJoltAPI.username,
			"user_token": GameJoltAPI.user_token,
			"achieved": false,
			"trophy_id": id
		})
		fetch_achieved.connect("api_request_completed", self, "_on_trophy_achieved")
		var trophy = GameJoltAPI.add_achieved({
			"username": GameJoltAPI.username,
			"user_token": GameJoltAPI.user_token,
			"trophy_id": id
		})

func _on_trophy_achieved(data: Array):
	send_notification("Trophy Achieved!", data[0].title + "\n" + data[0].description, "gj")

func checkIfModded():
	if Mod.isModded:
		get_tree().get_root().get_node("MainMenu").get_node("ModInfo")\
		.get_node("ModName").text = Mod.modName
		get_tree().get_root().get_node("MainMenu").get_node("ModInfo")\
		.get_node("ModVersion").text = Mod.modVersion
		get_tree().get_root().get_node("MainMenu").get_node("CreditsContainer")\
		.get_node("ModCredit").text = "Mod made by: " + Mod.modAuthor
	else:
		get_tree().get_root().get_node("MainMenu").get_node("ModInfo")\
		.get_node("ModName").visible = false
		get_tree().get_root().get_node("MainMenu").get_node("ModInfo")\
		.get_node("ModVersion").visible = false
		get_tree().get_root().get_node("MainMenu").get_node("CreditsContainer")\
		.get_node("ModCredit").visible = false

func open_settings():
	add_child(load("res://scenes/settings/Settings.tscn").instance())
