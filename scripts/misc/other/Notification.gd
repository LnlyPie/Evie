extends CanvasLayer

func send_notification(title: String, desc: String, icon: String):
	$Panel/NotTitle.text = title
	$Panel/NotDesc.text = desc
	if icon == "gj":
		$Panel/Sprite.texture = load("res://sprites/icons/misc/gj.png")
	$AnimationPlayer.play("Notification")
