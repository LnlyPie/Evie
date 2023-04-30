extends CanvasLayer

func change_scene(target: String, type: String = "Dissolve") -> void:
	# Dissolve/Fade Away
	if type == "Dissolve":
		$AnimationPlayer.play("Dissolve")
		yield($AnimationPlayer, "animation_finished")
		get_tree().change_scene(target)
		$AnimationPlayer.play_backwards("Dissolve")
	# Scale in/out
	if type == "Scale":
		$AnimationPlayer.play("Scale")
		yield($AnimationPlayer, "animation_finished")
		get_tree().change_scene(target)
		$AnimationPlayer.play_backwards("Scale")
