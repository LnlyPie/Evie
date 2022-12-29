extends CanvasLayer

func change_scene(target: String) -> void:
	$AnimationPlayer.play("Dissolve")
	yield($AnimationPlayer, "animation_finished")
	if get_tree().change_scene(target) != OK:
		print("Could not find scene: " + target)
	else:
		get_tree().change_scene(target)
	$AnimationPlayer.play_backwards("Dissolve")
