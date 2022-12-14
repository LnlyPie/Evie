extends Area2D

var active = false
var talked = false

func _ready() -> void:
	connect("body_entered", self, "_on_NPCTest_body_entered")
	connect("body_exited", self, "_on_NPCTest_body_exited")

func _process(delta):
	$ControllerSprite.visible = active
	if Input.is_action_just_pressed("player_interact") and active and !DialogueManager.is_dialogue_running:
		Utils.showDialogue("res://levels/test_level/dialogues/TestDialogue.tres", "npctest")

func _on_NPCTest_body_entered(body):
	if body.name == "Player":
		active = true

func _on_NPCTest_body_exited(body):
	if body.name == "Player":
		active = false
