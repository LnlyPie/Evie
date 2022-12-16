extends Node

var cfg = ConfigFile.new()

# Screen
var screen_width = 1920
var screen_height = 1080
var framerate_cap = 60
var fullscreen = true

# Audio
var master_volume = 1 # ex. 0.5 = 50%

# Gameplay
var language = "en"
var autosave = true

func save():
	# Screen
	cfg.set_value("Screen", "width", screen_width)
	cfg.set_value("Screen", "height", screen_height)
	cfg.set_value("Screen", "framerate", framerate_cap)
	cfg.set_value("Screen", "fullscreen", fullscreen)
	# Audio
	cfg.set_value("Audio", "master", master_volume)
	# Gameplay
	cfg.set_value("Gameplay", "language", language)
	cfg.set_value("Gameplay", "autosave", autosave)
	cfg.save("user://settings/settings.cfg")

func load():
	cfg.load("user://settings/settings.cfg")
	# Screen
	screen_width = cfg.get_value("Screen", "width")
	screen_height = cfg.get_value("Screen", "height")
	framerate_cap = cfg.get_value("Screen", "framerate")
	fullscreen = cfg.get_value("Screen", "fullscreen")
	# Audio
	master_volume = cfg.get_value("Audio", "master")
	# Gameplay
	language = cfg.get_value("Gameplay", "language")
	autosave = cfg.get_value("Gameplay", "autosave")

func apply():
	Settings.load()
	# Screen
	
	# Gameplay
	TranslationServer.set_locale(language)
	
