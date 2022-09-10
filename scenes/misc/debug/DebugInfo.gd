extends CanvasLayer

var debugTimer = null

func _ready():
	debugTimerInit()

func _on_Timer_timeout():
	$DebugInfoLabel.text = ("FPS: " + String(Engine.get_frames_per_second()))

func debugTimerInit():
	debugTimer = Timer.new()
	add_child(debugTimer)
	debugTimer.connect("timeout", self, "_on_Timer_timeout")
	debugTimer.set_wait_time(1.0)
	debugTimer.set_one_shot(false)
	debugTimer.start()
