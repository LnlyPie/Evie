extends RichTextLabel

func _on_CheatCodeListener_cheat_activated():
	visible = true
	bbcode_text = "\n[center][rainbow][tornado radius=5 freq=2][shake]%s[/shake][/tornado][/rainbow][/center]\n" % [
		"You have pressed the konami code!\nTry to find more Easter Eggs."
	]
