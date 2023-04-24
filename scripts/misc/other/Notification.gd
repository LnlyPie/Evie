extends CanvasLayer

var notification_queue = []
var notification_playing = false

func send_notification(title: String, desc: String, icon: String):
	var notification = {
		"title": title,
		"desc": desc,
		"icon": icon
	}
	notification_queue.append(notification)
	if not notification_playing:
		display_next_notification()

func display_next_notification():
	if notification_queue.size() == 0:
		notification_playing = false
		return
	notification_playing = true
	var notification = notification_queue[0]
	notification_queue.remove(0)
	$Panel/NotTitle.text = notification["title"]
	$Panel/NotDesc.text = notification["desc"]
	if notification["icon"] == "quest":
		$Panel/Sprite.scale = Vector2(3.5, 3.5)
		$Panel/Sprite.texture = load("res://sprites/icons/misc/quest.png")
	$AnimationPlayer.play("Notification")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play_backwards("Notification")
	yield($AnimationPlayer, "animation_finished")
	display_next_notification()
