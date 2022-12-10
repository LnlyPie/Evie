extends CanvasLayer

func send_notification(title: String, desc: String, icon: String):
	$Panel/NotTitle.text = title
	$Panel/NotDesc.text = desc
	if icon == "gj":
		$Panel/Sprite.scale = Vector2(3, 3)
		$Panel/Sprite.texture = load("res://sprites/icons/misc/gj.png")
	if icon == "quest":
		$Panel/Sprite.scale = Vector2(1.7, 1.7)
		$Panel/Sprite.texture = load("res://sprites/icons/misc/quest.png")
	$AnimationPlayer.play("Notification")
