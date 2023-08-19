extends Node

var dir = Directory.new()
var file = File.new()

# Folders/Directories
var photosFolder = "user://screenshots/"
var settingsFolder = "user://settings/"
var modsFolder = "user://mods/"
var savesFolder = "user://saves/"
var settingsFile = settingsFolder + "settings.cfg"
var execDir = OS.get_executable_path().get_base_dir() + "/"
var portable = execDir + "portable"

func isHtml():
	if OS.get_name() == "HTML5":
		return true

func isPortable():
	if file.file_exists(portable):
		photosFolder = execDir + "screenshots/"
		settingsFolder = execDir + "settings/"
		modsFolder = execDir + "mods/"
		savesFolder = execDir + "saves/"
		settingsFile = execDir + "settings/settings.cfg"

func checkFiles():
	isPortable()
	# Create directories
	if !dir.file_exists(photosFolder):
		dir.make_dir(photosFolder)
	if !dir.file_exists(settingsFolder):
		dir.make_dir(settingsFolder)
	if !dir.file_exists(modsFolder):
		dir.make_dir(modsFolder)
	if !dir.file_exists(savesFolder):
		dir.make_dir(savesFolder)
	# Create files
	if !file.file_exists(settingsFile):
		Settings.save()

func screenshot():
	var image = get_viewport().get_texture().get_data()
	image.flip_y()
	image.save_png(photosFolder + "screenshot-" + get_date_and_time() + ".png")

func makeImg(path):
	var image = Image.new()
	image.load(path)
	var t = ImageTexture.new()
	t.create_from_image(image)
	return t

func get_date_and_time(onlyone:int = 0, removeseconds = false):
	# Get Time and Date
	var systemDate = OS.get_date()
	var systemTime = OS.get_time()
	# Translate it to anything readable (ex. 2022-07-12_12:58:12)
	if onlyone == 0:
		var date_return = String(systemDate.year) + "-" + String(systemDate.month) + "-" + String(systemDate.day)
		var time_return = String(systemTime.hour) + ":" + String(systemTime.minute) + ":" + String(systemTime.second)
		# Return it
		var date_and_time = date_return + "_" + time_return
		return date_and_time
	elif onlyone == 1:
		var date = String(systemDate.year) + "-" + String(systemDate.month) + "-" + String(systemDate.day)
		return date
	elif onlyone == 2:
		var time
		if !removeseconds:
			time = String(systemTime.hour) + ":" + String(systemTime.minute) + ":" + String(systemTime.second)
		else:
			time = String(systemTime.hour) + ":" + String(systemTime.minute)
		return time
	else:
		return "failed"

func readable_timedate(timedate):
	var timedate_split = timedate.split("_", true, 1)
	return (timedate_split[0] + " " + timedate_split[1])

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

func read_json(path):
	var file = File.new()
	file.open(path, file.READ)
	var json = file.get_as_text()
	var json_result = JSON.parse(json).result
	file.close()
	return json_result

func str_to_vector2(cords):
	cords.erase(cords.find("("),1)
	cords.erase(cords.find(")"),1)
	cords.erase(cords.find(","),1)
	var x = cords.left(cords.find(" "))
	var y = cords.right(cords.find(" "))
	return Vector2(x,y)

func removeDirectoryWithFiles(directory_path: String):
	var dir = Directory.new()
	if dir.open(directory_path) == OK:
		dir.list_dir_begin()
		while true:
			var file_name = dir.get_next()
			if file_name == "":
				break
			var file_path = directory_path + "/" + file_name
			var file = File.new()
			if file.open(file_path, File.READ) == OK:
				file.close()
				if dir.remove(file_path) != OK:
					print("Could not remove file:", file_path)
			else:
				print("Could not open file:", file_path)
		dir.list_dir_end()
		if dir.remove(directory_path) == OK:
			print("Directory and files removed successfully.")
		else:
			print("Failed to remove directory:", directory_path)
	else:
		print("Directory not found:", directory_path)
