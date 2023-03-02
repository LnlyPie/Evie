extends CanvasLayer

var debugTimer = null
var player = Player.new()

func _ready():
	debugTimerInit()

func _on_Timer_timeout():
	$DebugInfoLabel.text = (get_fps_count() + "\n" + get_save_info() + "\n" + get_player_info() + "\n" + get_location())

func debugTimerInit():
	debugTimer = Timer.new()
	add_child(debugTimer)
	debugTimer.connect("timeout", self, "_on_Timer_timeout")
	debugTimer.set_wait_time(1.0)
	debugTimer.set_one_shot(false)
	debugTimer.start()

func get_fps_count():
	return ("FPS: " + String(Engine.get_frames_per_second()))

func get_save_info():
	return ("Save Info: Name \"" + Save.save_info["save_name"] + "\", Created " + Save.save_info["save_creation"])

func get_player_info():
	return ("Player Info: Name \"" + Save.player_data["name"] + "\", Health " + str(player.health))

func get_location():
	return ("Player Location: " + str(player.position))
