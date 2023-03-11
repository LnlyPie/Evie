extends Node

var cfg = ConfigFile.new()

# Screen
var screen_width = 960
var screen_height = 544
var framerate_cap = 60

# Audio
var master_volume = 1 # ex. 0.5 = 50%

# Gameplay
var language = "en"
var autosave = true

# Vars
var seenAutoMsg = false

func save():
	# Screen
	cfg.set_value("Screen", "width", screen_width)
	cfg.set_value("Screen", "height", screen_height)
	cfg.set_value("Screen", "framerate", framerate_cap)
	# Audio
	cfg.set_value("Audio", "master", master_volume)
	# Gameplay
	cfg.set_value("Gameplay", "language", language)
	cfg.set_value("Gameplay", "autosave", autosave)
	# Vars
	cfg.set_value("Variables", "seen_autosave_message", seenAutoMsg)
	cfg.save(Utils.settingsFile)

func load():
	cfg.load(Utils.settingsFile)
	# Screen
	screen_width = cfg.get_value("Screen", "width")
	screen_height = cfg.get_value("Screen", "height")
	framerate_cap = cfg.get_value("Screen", "framerate")
	# Audio
	master_volume = cfg.get_value("Audio", "master")
	# Gameplay
	language = cfg.get_value("Gameplay", "language")
	autosave = cfg.get_value("Gameplay", "autosave")
	# Vars
	seenAutoMsg = cfg.get_value("Variables", "seen_autosave_message")

func apply():
	# Screen
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,\
	 SceneTree.STRETCH_ASPECT_EXPAND, Vector2(screen_width, screen_height))
	Engine.set_target_fps(framerate_cap)
	# Audio
	
	# Gameplay
	TranslationServer.set_locale(language)

func apply_onstart():
	Settings.load()
	apply()
