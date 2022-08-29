extends Node

onready var player = get_parent().get_parent().get_parent().get_node("Player")

enum {
	ARG_INT,
	ARG_STRING,
	ARG_BOOL,
	ARG_FLOAT
}

const valid_commands = [
	["set_speed",
		[ARG_FLOAT]],
	["help",
		[]]
]

func help():
	return str("Avaliable Commands:\n help - Shows this message\n set_speed (num) - sets player speed")

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
