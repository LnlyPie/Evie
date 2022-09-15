extends Node

var dir = Directory.new()

var photosFolder = "user://screenshots/"
var settingsFolder = "user://settings/"

func _ready():
	if !dir.file_exists(photosFolder):
		dir.make_dir(photosFolder)
	if !dir.file_exists(settingsFolder):
		dir.make_dir(settingsFolder)

func screenshot():
	var image = get_viewport().get_texture().get_data()
	image.flip_y()
	image.save_png(photosFolder + "screenshot-" + getDateAndTime() + ".png")

func getDateAndTime():
	# Get Time and Date
	var systemDate = OS.get_date()
	var systemTime = OS.get_time()
	# Translate it to anything readable (ex. 2022-07-12_12:58:12)
	var date_return = String(systemDate.year) + "-" + String(systemDate.month) + "-" + String(systemDate.day)
	var time_return = String(systemTime.hour) + ":" + String(systemTime.minute) + ":" + String(systemTime.second)
	# Return it
	var date_and_time = date_return + "_" + time_return
	return date_and_time

func saveSettings():
	# Laaaater
	var fullscreen = Settings.fullscreen

func sendNotification():
	# To do laaaater
	add_child(load("res://scenes/misc/miscmisc/Notification.tscn").instance())
	var test = get_parent()
	print(test)
	#$Panel/NotTitle.text = title
	#$Panel/NotDesc.text = desc
	#if icon == "gj":
	#	$Panel/Sprite.texture = load("res://gj.png")
	#$AnimationPlayer.play("Notification")
