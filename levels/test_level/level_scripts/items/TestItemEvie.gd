extends Area2D

var active = false

var evieitem = ItemData.new("Evie", "An Evie", load("res://sprites/faces/Evie/Evie_normal.png"))

func _process(delta):
	$ControllerSprite.visible = active
	if Input.is_action_just_pressed("player_interact") and active:
		if !Inv.has_item(evieitem):
			Inv.add_item_to_inventory(evieitem)
	if Inv.has_item(evieitem):
		self.visible = false

func _on_TestItemEvie_body_entered(body):
	if self.visible == true:
		if body.name == "Player":
			active = true

func _on_TestItemEvie_body_exited(body):
	if body.name == "Player":
		active = false
