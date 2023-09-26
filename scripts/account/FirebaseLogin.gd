extends Node

func _ready():
	if (!Firebase.Auth.is_logged_in()):
		Firebase.Auth.check_auth_file()
	yield(get_tree().create_timer(1), "timeout")
	print("LP Login status: " + str(Firebase.Auth.is_logged_in()))

func login(email: String, passwd: String):
	Firebase.Auth.login_with_email_and_password(email, passwd)
	Firebase.Auth.connect("login_succeeded", self, "_login_success")

func _login_success(auth):
	Firebase.Auth.save_auth(auth)
	SceneTransition.change_scene("res://scenes/account/Account.tscn")

func _closed_popup():
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")
