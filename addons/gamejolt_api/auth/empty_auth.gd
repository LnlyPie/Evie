extends Node

func set_game_creds():
	# Change empty_auth.gd to auth.gd
	# Add to autoload
	# You don't need to fill that up (empty auth.gd was made only for the try_autologin() function)
	GameJoltAPI.set_game_credentials({
		"game_id": "",
		"private_key": ""
	})

# Works only when on GameJolt Client
func try_autologin():
	GameJoltAPI.get_user_credentials()

func login(username: String, token: String):
	GameJoltAPI.username = username
	GameJoltAPI.user_token = token

# Although auth.gd won't get onto github
# Don't forget to remove your credentials
# Just for safety ;)
func debug_login():
	GameJoltAPI.username = "Your username without @"
	GameJoltAPI.user_token = "Your user token"
