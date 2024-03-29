extends CanvasLayer

class_name InventoryUI

var inventory
var item_list
var popup
var current_hover_vbox

func _ready():
	hide_inventory()
	inventory = Inventory.new()
	item_list = $ScrollContainer/VBoxContainer
	popup = PopupPanel.new()
	popup.rect_min_size = Vector2(400, 200)
	add_child(popup)

	update_inventory_ui()

func _on_inventory_mouse_entered():
	popup.visible = false

func _on_inventory_mouse_exited():
	popup.visible = false

# Add/Remove an item to the inventory
func add_item_to_inventory(item: ItemData) -> bool:
	if inventory.add_item(item):
		update_inventory_ui()
		return true
	return false
func remove_item_from_inventory(item: ItemData) -> bool:
	if inventory.remove_item(item):
		update_inventory_ui()
		return true
	return false

# Update the UI to reflect the current state of the inventory
func update_inventory_ui():
	clear_inventory_ui()
	for i in range(inventory.get_item_count()):
		var item_data = inventory.get_item_at(i)
		var item_icon = TextureRect.new()
		item_icon.texture = item_data.icon
		item_icon.rect_min_size = Vector2(50, 50)
		item_icon.rect_scale = Vector2(1, 1)
		item_icon.mouse_filter = Control.MOUSE_FILTER_STOP
		item_icon.connect("mouse_entered", self, "_on_item_icon_mouse_entered", [item_data])
		item_icon.connect("mouse_exited", self, "_on_item_icon_mouse_exited")
		item_list.add_child(item_icon)

# Clear the inventory UI
func clear_inventory_ui():
	for child in item_list.get_children():
		if child is TextureRect:
			item_list.remove_child(child)

# Show item details on hover
func _on_item_icon_mouse_entered(item_data: ItemData):
	var vbox = VBoxContainer.new()
	vbox.rect_min_size = Vector2(400, 200)
	vbox.set_anchor(MARGIN_RIGHT, 1.0)
	vbox.set_anchor(MARGIN_BOTTOM, 1.0)

	var name_label = Label.new()
	name_label.text = item_data.name
	name_label.set_theme(load("res://fonts/comfortaa/SmallTextTheme.tres"))
	vbox.add_child(name_label)

	var desc_label = Label.new()
	desc_label.text = item_data.description
	desc_label.rect_min_size = Vector2(380, 100)
	desc_label.set_autowrap(true)
	desc_label.set_custom_minimum_size(Vector2(380, 0))
	desc_label.set_theme(load("res://fonts/comfortaa/SmallerTextTheme.tres"))
	vbox.add_child(desc_label)

	current_hover_vbox = vbox
	popup.add_child(vbox)
	popup.rect_position = get_viewport().get_mouse_position()
	popup.visible = true
func _on_item_icon_mouse_exited():
	popup.visible = false
	if current_hover_vbox:
		current_hover_vbox.queue_free()
		current_hover_vbox = null

func show_inventory():
	self.visible = true
func hide_inventory():
	self.visible = false

func get_item_at(index: int) -> ItemData:
	return inventory.items[index]
func has_item(item: ItemData) -> bool:
	return inventory.items.find(item) != -1
func get_item_count() -> int:
	return inventory.items.size()

func get_items_from_array() -> Array:
	return inventory.items
func set_items_to_array(array: Array):
	inventory.items = array
