extends Control

onready var input_box = $Console/InputBox
onready var output_box = $Console/OutputBox
onready var command_handler = $CommandHandler

var commandHistoryLine = CommandHistory.history.size()

func _ready():
	input_box.grab_focus()
	CursorOptions.show_cursor(true)

func _process(delta):
	if Input.is_action_just_pressed("debug_console"):
		CursorOptions.show_cursor(false)
		get_tree().paused = false
		queue_free()
		
func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.scancode == KEY_UP:
			goto_command_history(-1)
		if event.scancode == KEY_DOWN:
			goto_command_history(1)

func goto_command_history(offset):
	commandHistoryLine += offset
	commandHistoryLine = clamp(commandHistoryLine, 0, CommandHistory.history.size())
	if commandHistoryLine < CommandHistory.history.size() and CommandHistory.history.size() > 0:
		input_box.text = CommandHistory.history[commandHistoryLine]
		input_box.call_deferred("set_cursor_position", 99999999)

func process_command(text):
	var command = text.split(" ")
	command = Array(command)
	for i in range(command.count("")):
		command.erase("")
	
	if command.size() == 0:
		return
	
	CommandHistory.history.append(text)
	
	var command_word = command.pop_front()
	
	for c in command_handler.valid_commands:
		if c[0] == command_word:
			if command.size() != c[1].size():
				output_text(str("Failed executing command '", command_word, "', expected ", c[1].size(), " parameter(s)"))
				return
			for i in range(command.size()):
				if not check_type(command[i], c[1][i]):
					output_text(str("Failed executing command '", command_word, "', parameter ", (i +1),
					" ('", command[i], "') is of the wrong type"))
					return
			output_text(command_handler.callv(command_word, command))
			return
	output_text(str("Command '", command_word, "' does not exist."))

func check_type(string, type):
	if type == command_handler.ARG_INT:
		return string.is_valid_integer()
	if type == command_handler.ARG_FLOAT:
		return string.is_valid_float()
	if type == command_handler.ARG_STRING:
		return true
	if type == command_handler.ARG_BOOL:
		return (string == "true" or string == "false")
	return false

func output_text(text):
	output_box.text = str(output_box.text, "\n", text)
	output_box.set_v_scroll(9999999)

func _on_InputBox_text_entered(new_text):
	input_box.clear()
	process_command(new_text)
	commandHistoryLine = CommandHistory.history.size()
