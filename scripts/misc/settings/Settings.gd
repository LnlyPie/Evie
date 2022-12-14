extends Node

# Screen
var screen_width = 1920
var screen_height = 1080
var framerate_cap = 60
var fullscreen = true

# Audio
var master_volume = 100

# Gameplay
var autosave = true

func apply_settings():
	get_viewport().set_size(Vector2(screen_width, screen_height))
