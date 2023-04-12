extends CanvasLayer

# For later to add notifications queue
var notification_playing = false

func send_notification(title: String, desc: String, icon: String):
	$Panel/NotTitle.text = title
	$Panel/NotDesc.text = desc
	if icon == "gj":
		$Panel/Sprite.scale = Vector2(6, 6)
		$Panel/Sprite.texture = load("res://sprites/icons/misc/gj.png")
	if icon == "quest":
		$Panel/Sprite.scale = Vector2(3.5, 3.5)
		$Panel/Sprite.texture = load("res://sprites/icons/misc/quest.png")
	$AnimationPlayer.play("Notification")
	yield(get_tree().create_timer(2.5), "timeout")
	$AnimationPlayer.play_backwards("Notification")
