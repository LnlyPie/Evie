extends Node

func set_game_creds():
	# Change empty_auth.gd to auth.gd
	# You don't need to fill that up (empty auth.gd was made only for the try_autologin() function)
	GameJoltAPI.set_game_credentials({
		"game_id": "",
		"private_key": ""
	})

# Works only when on GameJolt Client
func try_autologin():
	GameJoltAPI.get_user_credentials()
