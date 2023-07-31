extends StaticBody2D

func _on_PlayerDetector_body_entered(body):
	if body.name == "Player":
		$AnimationPlayer.play("tree_modulation")

func _on_PlayerDetector_body_exited(body):
	if body.name == "Player":
		$AnimationPlayer.play_backwards("tree_modulation")
