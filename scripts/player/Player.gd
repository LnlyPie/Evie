extends KinematicBody2D

export(int) var normalSpeed = 100.0
export(float) var sprintMultiplier = 1.5
var speed = normalSpeed

func _process(delta):
	var velocity = Vector2.ZERO
	# Basic Movement
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
		speed = normalSpeed
	velocity = velocity.normalized()
	
	# Animations
	if velocity == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		$AnimationTree.get("parameters/playback").travel("Walk")
		$AnimationTree.set("parameters/Walk/blend_position", velocity)
		move_and_slide(velocity * speed)
