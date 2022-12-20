extends Control

func _ready():
	$AnimationPlayer.play("Save")
	if Settings.autosave:
		if Settings.seenAutoMsg:
			SceneTransition.change_scene("res://scenes/MainMenu.tscn")
		else:
			yield(get_tree().create_timer(2.5), "timeout")
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")
