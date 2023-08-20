extends Node

var has_talked_testnpc: bool = false
func addquest():
	Quests.new("Test Quest", "Find two LonelyPie logos!", 2)

func _process(delta):
	if Quests.exists("Test Quest"):
		if Quests.is_completed("Test Quest"):
			AchievementManager.unlock("Test and Find")
			has_talked_testnpc = true
