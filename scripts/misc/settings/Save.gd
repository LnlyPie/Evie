extends Node

var file = File.new()
var json = JSON

func save(slot: int):
	var save_data = {
		"player_health": PlayerConsts.player_health,
		"player_posx": PlayerConsts.player_x,
		"player_posy": PlayerConsts.player_y,
		"game_chapter": PlayerConsts.chapter
	}
	
	var json_data = json.print(save_data)
	
	if file.open("user://saves/saveslot_" + str(slot) + ".json", File.WRITE):
		file.store_string(json_data)
		file.close()

func load(slot: int):
	if file.open("user://saves/saveslot_" + str(slot) + ".json", File.READ):
		var json_data = file.get_as_text()
		
		var save_data = json.parse(json_data)
		
		PlayerConsts.player_health = save_data["player_health"]
		PlayerConsts.player_x = save_data["player_posx"]
		PlayerConsts.player_y = save_data["player_posy"]
		PlayerConsts.chapter = save_data["game_chapter"]
		
		file.close()
