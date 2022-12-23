extends Area2D

var active = false
var found = false

func _ready() -> void:
	connect("body_entered", self, "_on_NPCTest_body_entered")
	connect("body_exited", self, "_on_NPCTest_body_exited")

func _process(delta):
	$ControllerSprite.visible = active
	if Input.is_action_just_pressed("player_interact") and active and !found and !Quests.is_completed("Test Quest"):
		Quests.add_progress("Test Quest", 1)
		found = true

func _on_Logo2_body_entered(body):
	if body.name == "Player":
		active = true

func _on_Logo2_body_exited(body):
	if body.name == "Player":
		active = false
