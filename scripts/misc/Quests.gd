extends Node

var quests = {}

# Quests.new("Some Quest", "A description for the quest")
func new(name: String, description: String, maxprogress: int = 100):
	var quest = {
		"name": name,
		"description": description,
		"progress": 0,
		"max_progress": maxprogress,
		"completed": false
	}
	quests[name] = quest
	Utils.send_notification("New Quest Avaliable!", name + "\n" + description, "quest")

func add_progress(name, progress: int):
	if quests[name]["progress"] != quests[name]["max_progress"]:
		quests[name]["progress"] += progress

func complete(name):
	quests[name]["completed"] = true
	Utils.send_notification("Quest completed", name, "quest")

func is_completed(name):
	return quests[name]["completed"]

func exists(name):
	return quests.has(name)

func get_desc(name):
	return quests[name]["description"]

func get_progress(name):
	return quests[name]["progress"]

func get_max_progress(name):
	return quests[name]["max_progress"]

func _process(delta):
	_check_quests()

func _check_quests():
	for quest in quests:
		if get_progress(quest) == get_max_progress(quest):
			if !is_completed(quest):
				complete(quest)
