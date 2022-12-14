extends Node

var has_talked_testnpc: bool = false
func addquest():
	Quests.new("Test Quest", "Talk to Test NPC again.")
func completequest():
	Quests.complete("Test Quest")
