extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 10
const MAXFALLSPEED = 350
const JUMPFORCE = 250
var MAXSPEED = 100
var MAXSPEED_OLD = MAXSPEED
var MAXSPEED_TEMP = MAXSPEED*1.5

const ACCEL = 10

var motion = Vector2()
var facing_right = true

func _ready():
	pass

func _physics_process(_delta):
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
		
	if facing_right:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1

	motion.x = clamp(motion.x,-MAXSPEED,MAXSPEED)
	
	# Menu Control
	if Input.is_action_just_pressed("pause"):
		get_tree().quit()

	# Player Movement
	if Input.is_action_pressed("player_right"):
		motion.x += ACCEL
		facing_right = true
		$AnimationPlayer.play("PlayerWalk")
	elif Input.is_action_pressed("player_left"):
		motion.x -= ACCEL
		facing_right = false
		$AnimationPlayer.play("PlayerWalk")
	else:
		motion.x = lerp(motion.x,0,0.2)
		$AnimationPlayer.stop()
		$Sprite.frame = 0

	# Sprint and Jump
	if Input.is_action_just_pressed("player_up"):
		motion.y = -JUMPFORCE
		
	if Input.is_action_pressed("player_sprint"):
		MAXSPEED = MAXSPEED_TEMP
	else:
		MAXSPEED = MAXSPEED_OLD

	motion = move_and_slide(motion, UP)
