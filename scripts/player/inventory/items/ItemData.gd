extends Reference

class_name ItemData

export var name: String
export var description: String
export var icon: Texture

func _init(name: String, description: String, icon: Texture):
	self.name = name
	self.description = description
	self.icon = icon
