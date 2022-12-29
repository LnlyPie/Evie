extends Control

var selected = 0

func _ready():
	_list_mods()

func _list_mods():
	var files = []
	var listid = 0
	var dir = Directory.new()
	var cfg = ConfigFile.new()
	dir.open(Utils.modsFolder)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			if !files.has(file):
				var modinfo = Utils.modsFolder + file + "/Mod.cfg"
				if dir.file_exists(modinfo):
					cfg.load(modinfo)
					$ItemList.add_item(str(cfg.get_value("ModInfo", "name")) + " " + \
					 str(cfg.get_value("ModInfo", "version")) + " - " + \
					 str(cfg.get_value("ModInfo", "author")), load("res://sprites/gui/mods/modicon.png"))
					$ItemList.set_item_metadata(listid, file)
					files.append(file)
					listid += 1
	dir.list_dir_end()

func _on_ApplyButton_pressed():
	ModLoader.apply_mod(selected)

func _on_BackButton_pressed():
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")

func _on_ItemList_item_selected(index):
	selected = $ItemList.get_item_metadata(index)
