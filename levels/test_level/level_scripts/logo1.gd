extends Area2D

var active = false
var found = false

func _process(delta):
	$ControllerSprite.visible = active
	if Input.is_action_just_pressed("player_interact") and active and !found and Quests.exists("Test Quest"):
		Quests.add_progress("Test Quest", 1)
		found = true

func _on_Logo1_body_entered(body):
	if body.name == "Player" and !found:
		active = true

func _on_Logo1_body_exited(body):
	if body.name == "Player":
		active = false
