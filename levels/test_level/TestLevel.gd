extends YSort

func _ready():
	Save.set_chapter(-1, 1)
	if Quests.is_completed("Test Quest"):
		TestlevelStates.has_talked_testnpc = true
	else:
		TestlevelStates.has_talked_testnpc = false
