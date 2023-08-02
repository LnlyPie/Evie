extends Control

var username
var userdata_received = false

func _ready():
	$Login.visible = false
	$Manage.visible = false
	$LoginLabel.visible = false
	$ManageLabel.visible = false
	
	if Firebase.Auth.is_logged_in():
		Firebase.Auth.connect("userdata_received", self, "_on_userdata_received")
		yield(get_tree().create_timer(1), "timeout")
		Firebase.Auth.get_user_data()
		$Manage.visible = true
		$ManageLabel.visible = true
	else:
		$LoginLabel.visible = true
		$Login.visible = true

# Login to Account
func _on_RegisterButton_pressed():
	OS.shell_open("https://account.lonelypie.net/register")
func _on_LoginButton_pressed():
	FirebaseLogin.login($Login/Email/Value.text, $Login/Password/Value.text)

# Manage Account
func _on_LogoutButton_pressed():
	Firebase.Auth.logout()
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")
func _on_ManageButton_pressed():
	OS.shell_open("https://account.lonelypie.net/account")


func _on_userdata_received(userdata) -> void:
	var strdata = str(userdata)
	var lines = strdata.split("\n")
	for line in lines:
		if line.find("display name") != -1:
			var parts = line.split(":")
			if parts.size() > 1:
				username = parts[1]
				$Manage/LoggedInAs.text = "Logged in as:" + username
			else:
				username = "Name not found"
		else:
			username = "Name not found"
	username = "Name not found"


func _on_BackButton_pressed():
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")
