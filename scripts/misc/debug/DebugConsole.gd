extends Control

onready var input_box = $Console/InputBox
onready var output_box = $Console/OutputBox

func _ready():
	input_box.grab_focus()

func output_text(text):
	output_box.text = str(output_box.text, "\n", text)
	output_box.set_v_scroll(9999999)

func _on_InputBox_text_entered(new_text):
	input_box.clear()
	output_text(new_text)
