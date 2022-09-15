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

const valid_commands = [
	["set_speed",
		[ARG_FLOAT]],
	["photo_cam",
		[]],
	["debug_info",
		[]],
	["quit",
		[]],
	["help",
		[]]
]

func help():
	return str("Avaliable Commands:\n set_speed [number] - sets player speed\n photo_cam [true/false] - turns on/off photo cam mode\n debug_info - shows debug info\n quit - closes the game\n help - Shows this message")

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
		level.add_child(load("res://scenes/misc/miscmisc/PhotoCam.tscn").instance())
		return "Photo Camera On\nTo Make a screenshot use P (on Keyboard) or R1 (on DualShock)"
	else:
		camera2d.make_current()
		player.photoCam = false
		level.remove_child(level.get_node("PhotoCam"))
		return "Photo Camera Off"

func debug_info():
	if !player.debugInfo:
		level.add_child(load("res://scenes/misc/debug/DebugInfo.tscn").instance())
		player.debugInfo = true
		return "Showing Debug Info"
	else:
		level.remove_child(level.get_node("DebugInfo"))
		player.debugInfo = false
		return "Hiding Debug Info"

func quit():
	get_tree().quit()
