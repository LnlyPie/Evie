extends Sprite

func _ready():
	yield(get_tree().create_timer(1), "timeout")
	SceneTransition.change_scene("res://other_scenes/MainMenu.tscn")
