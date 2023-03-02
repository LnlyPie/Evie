extends Node

onready var player = get_parent().get_parent().get_parent().get_node("Player")
onready var camera2d = player.get_node("Camera2D")
onready var level = get_parent().get_parent().get_parent()

enum {
	ARG_INT,
	ARG_STRING,
	ARG_BOOL,
	ARG_FLOAT
}

var valid_commands = [
	["set_speed",
		[ARG_FLOAT]],
	["photo_cam",
		[]],
	["gb_filter",
		[]],
	["debug_info",
		[]],
	["run_dialogue",
		[ARG_STRING, ARG_STRING]],
	["send_notification",
		[ARG_STRING, ARG_STRING, ARG_STRING]],
	["clear",
		[]],
	["save_game",
		[ARG_STRING]],
	["load_game",
		[ARG_STRING]],
	["set_health",
		[ARG_INT]],
	["exit",
		[]],
	["help",
		[]]
]

func help():
	return str("Avaliable Commands:\n set_speed [number] - sets player speed\n " \
	+ "photo_cam - turns on/off photo cam mode\n run_dialogue [name] [node] - shows dialogue\n " \
	+ "send_notification [title] [description] [icon] - sends a notification\n gb_filter - Turns on GameBoy Filter\n " \
	+ "save_game [slot] - save the game\n load_game - load the game\n " \
	+ "set_health [quantity] - sets player health from 1-5" \
	+ "debug_info - shows debug info\n exit - closes the game\n " \
	+ "clear - clears the console\n help - Shows this message")

func set_speed(speed):
	speed = float(speed)
	if speed >= 1 and speed <= 1000:
		player.speedChangedDebug = true
		player.speed = speed
		if speed == player.normalSpeed:
			player.speedChangedDebug = false
			return "Speed set to default."
		return str("Successfully changed speed to ", speed, ".")
	return "The speed value must be between 1 and 1000."

func photo_cam():
	if !player.photoCam:
		camera2d.current = false
		player.photoCam = true
		level.add_child(load("res://scenes/misc/other/PhotoCam.tscn").instance())
		return "Photo Camera On\nGo Make a screenshot!"
	else:
		camera2d.make_current()
		player.photoCam = false
		level.remove_child(level.get_node("PhotoCam"))
		return "Photo Camera Off"

func run_dialogue(dialogueName, dialogueNode):
	# Ex. prologue/dialogues/imokayida, im_okay_ida
	Utils.showDialogue("res://levels/" + dialogueName + ".tres", dialogueNode)
	return "Dialogue Shown"

func send_notification(title, desc, icon):
	Utils.send_notification(title, desc, icon)
	return "Close debug console to see the notification"

func gb_filter():
	if !player.gb_filter:
		player.gb_filter = true
		return "GameBoy Filter On"
	else:
		player.gb_filter = false
		return "GameBoy Filter Off"

func debug_info():
	if !player.debugInfo:
		level.add_child(load("res://scenes/misc/debug/DebugInfo.tscn").instance())
		player.debugInfo = true
		return "Showing Debug Info"
	else:
		level.remove_child(level.get_node("DebugInfo"))
		player.debugInfo = false
		return "Hiding Debug Info"

func clear():
	level.get_node("DebugConsole").get_node("DebugConsole").get_node("Console").get_node("OutputBox").text = "Cleared"
	return ""
	
func save_game(slot):
	Save.save_data(slot)
	return ("Saved game on slot " + slot)

func load_game(slot):
	Save.load_data(slot)
	return ("Loaded game from slot " + slot)

func set_health(quantity):
	quantity = int(quantity)
	if quantity >= 1 && quantity <= 5:
		player.health = quantity
		return ("Player's health set to " + str(quantity))
	else:
		return "Too big number of health"

func exit():
	get_tree().quit()
	return "Exitting..."
