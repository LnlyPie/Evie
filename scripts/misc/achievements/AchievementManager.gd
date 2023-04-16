extends Node

var achievements := {}
var achievement_file = (Save.get_slot_folder() + "achievements.json")

func add_achievement(name: String, description: String):
	achievements[name] = {
		name = name,
		description = description,
		unlocked = false
	}

func unlock(name: String):
	if achievements.has(name):
		if !is_unlocked(name):
			print("Achievement Unlocked")
			achievements[name].unlocked = true
			save_achievements()

func save_achievements():
	var ach_save = {}
	for achievement in achievements:
		ach_save[achievement] = achievements[achievement]

	var file = File.new()
	file.open(achievement_file, File.WRITE)
	file.store_string(to_json(ach_save))
	file.close()

func load_achievements():
	var file = File.new()
	if file.file_exists(achievement_file):
		file.open(achievement_file, File.READ)
		var json_str = file.get_as_text()
		var progress = parse_json(json_str)
		
		for achievement in achievements:
			if progress.has(achievement):
				achievements[achievement].unlocked = progress[achievement]
		file.close()

func is_unlocked(name: String) -> bool:
	if achievements.has(name):
		return achievements[name].unlocked
	return false

func init_achievements():
	add_achievement("My Achievement", "Description of my achievement")
	add_achievement("Achievement 2", "Another Achievement")
