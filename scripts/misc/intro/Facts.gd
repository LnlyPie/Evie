extends Control

func _ready():
	_random_fact()
	$ControllerTextureRect.visible = false
	yield(get_tree().create_timer(2), "timeout")
	$ControllerTextureRect.visible = true
	$AnimationPlayer.play("show_button")

func _random_fact():
	randomize()
	var fact = randi()%2+1
	if fact == 1:
		$Fact.bbcode_text = "That earlier versions of Evie were inspired by [wave amp=100][color=aqua]Celeste[/color]?[/wave]"
	if fact == 2:
		$Fact.bbcode_text = "That [color=lime]Avocados[/color] are a fruit?"

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		SceneTransition.change_scene("res://scenes/MainMenu.tscn")
