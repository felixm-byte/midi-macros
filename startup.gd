extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var dir := DirAccess.open("user://macros")
	if dir:
		for macro in dir.get_files():
			var m: Macro = ResourceLoader.load("user://macros/" + macro)
			var interpreter: MacroInterpreter = MacroInterpreter.new()
			interpreter.start(m)
			add_child(interpreter)
	Utility.open_device()

func _input(event):
	if event is InputEventMIDI:
		var e = Utility.convert_to_standard(event)
		for i in get_children():
			if i is MacroInterpreter:
				i.action_occured(e)
