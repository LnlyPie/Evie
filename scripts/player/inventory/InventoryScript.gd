extends Node

class_name Inventory

export var maxCapacity: int = 10

var items: Array = []

func add_item(item: ItemData) -> bool:
	if items.size() >= maxCapacity:
		return false
	
	items.append(item)
	return true
func remove_item(item: ItemData) -> bool:
	var index = items.find(item)
	if index != -1:
		items.remove(index)
		return true
	return false

func get_item_at(index: int) -> ItemData:
	return items[index]
func has_item(item: ItemData) -> bool:
	return items.find(item) != -1
func get_item_count() -> int:
	return items.size()
