extends Control

func _ready():
	$AnimationPlayer.play("Save")
	if Settings.autosave:
		yield(get_tree().create_timer(1.5), "timeout")
		Settings.seenAutoMsg = true
		Settings.save()
	SceneTransition.change_scene("res://scenes/MainMenu")

func _visibility(vis: bool):
	$Label.visible = vis
	$Sprite.visible = vis
