extends Node2D

func _ready():
	$AnimationPlayer.play("Save")
	yield(get_tree().create_timer(1.5), "timeout")
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")
