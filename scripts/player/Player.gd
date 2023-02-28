extends KinematicBody2D

export(float) var normalSpeed = 100.0
export(float) var sprintMultiplier = 1.5
var speed = normalSpeed
var speedChangedDebug = false

var photoCam = false
var gb_filter = false
var debugInfo = false
var blockMovement = false

func _process(_delta):
	var velocity = Vector2.ZERO
	# Basic Movement
	if !blockMovement:
		if Input.is_action_pressed("player_right"):
			velocity.x += 1.0
		if Input.is_action_pressed("player_left"):
			velocity.x -= 1.0
		if Input.is_action_pressed("player_down"):
			velocity.y += 1.0
		if Input.is_action_pressed("player_up"):
			velocity.y -= 1.0
		# Sprinting
		if Input.is_action_pressed("player_sprint"):
			speed = (normalSpeed*sprintMultiplier)
		else:
			if !speedChangedDebug:
				speed = normalSpeed
		velocity = velocity.normalized()
	
	_save_player_loc()
	
	# Debug
	debug()
	
	# Animations
	if velocity == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		$AnimationTree.get("parameters/playback").travel("Walk")
		$AnimationTree.set("parameters/Walk/blend_position", velocity)
	move_and_slide(velocity * speed)

func debug():
	# Debug Console
	if Input.is_action_just_pressed("debug_console"):
		get_parent().add_child(load("res://scenes/misc/debug/DebugConsole.tscn").instance())
		get_tree().paused = true
	# GameBoy Filter
	if gb_filter:
		$CanvasLayer/GB_Filter.visible = true
		OS.set_window_title("Evie - GameBoy Edition")
	else:
		$CanvasLayer/GB_Filter.visible = false
		OS.set_window_title("Evie")
	# Screenshots
	if Input.is_action_just_pressed("screenshot"):
		if photoCam:
			get_parent().get_node("PhotoCam").get_node("UseText").visible = false
			yield(get_tree().create_timer(0.5), "timeout")
			Utils.screenshot()
			get_parent().get_node("PhotoCam").get_node("UseText").visible = true

func _ready():
	if Save.exists(Save.slot_picked):
		Save.load_data(Save.slot_picked)
		if Save.player_data["last_location"] != "":
			set_position(Utils.str_to_vector2(Save.player_data["last_location"]))

func _save_player_loc():
	Save.player_data["last_location"] = position
	Save.save_data(Save.slot_picked)
