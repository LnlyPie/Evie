extends Control

func _ready():
	_random_fact()
	yield(get_tree().create_timer(2), "timeout")
	$InputContainer.visible = true
	$AnimationPlayer.play("show_button")
	yield(get_tree().create_timer(0.7), "timeout")
	$AnimationPlayer.play("button_pulsating")

func _random_fact():
	randomize()
	var fact = randi()%4+1
	$Fact.bbcode_text = _read_facts()["fact" + str(fact)]

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") || Input.is_action_just_pressed("mouse_left"):
		SceneTransition.change_scene("res://scenes/MainMenu.tscn")

func _read_facts():
	return Utils.read_json("res://other/jsons/facts.json")
