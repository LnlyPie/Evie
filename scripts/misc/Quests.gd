extends Node

var quests = {}
var quests_completed = Save.player_data["quests_completed"]

# Quests.new("Some Quest", "A description for the quest")
func new(name: String, description: String, maxprogress: int = 100):
	if (!quests_completed.has(name)):
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
	Save.player_data["quests_completed"].append(name)
	quests.erase(name)
	Utils.send_notification("Quest completed", name, "quest")

func is_completed(name):
	if quests_completed.has(name):
		return true
	else:
		return false

func exists(name):
	return quests.has(name)

func get_desc(name):
	if Quests.exists(name):
		return quests[name]["description"]
	else:
		return false

func get_progress(name):
	if Quests.exists(name):
		return quests[name]["progress"]
	else:
		return false

func get_max_progress(name):
	if Quests.exists(name):
		return quests[name]["max_progress"]
	else:
		return false

func get_progress_now_max(name):
	if Quests.exists(name):
		return str(quests[name]["progress"]) + "/" + str(quests[name]["max_progress"])
	else:
		return false

func _process(delta):
	quests_completed = Save.player_data["quests_completed"]
	_check_quests()

func _check_quests():
	for quest in quests:
		if get_progress(quest) == get_max_progress(quest):
			if !is_completed(quest):
				complete(quest)
