extends Control
var states: Array[Macro] = []
var undone_state: Macro
var panel = preload("res://update_panel.tscn")
@onready var code = $VBoxContainer/TabContainer/Code
func something_changed():
	if len(states) == 10:
		for i in len(states):
			if i == 0:
				break
			else:
				states[i-1] = states[i]
	states.append(code.get_macro())
var none:= func(): pass
func undo():
	undone_state = code.get_macro()
	if len(states) <= 2:
		var n = panel.instantiate()
		n._generate_ui(['BigText', "Confirm"], ["Nothing to undo", "OK"], none)
		get_tree().root.add_child(n)
		return
	code.set_state(states[-2])
	states.remove_at(states.size()-1)
func redo():
	code.set_state(undone_state)
#This is a bit of a r/programminghorror, easiest solution though so :shrug:
func handle_menu(path, _popup_menu, _item_index, _section_indices):
	print(path)
	match path:
		"File/New Macro":
			code.set_state(Macro.new())
		"File/Close Macro":
			#Change screen to editor start screen
			pass
		"Edit/Undo":
			undo()
		"Edit/Redo":
			redo()
		"File//About":
			var n = panel.instantiate()
			n._generate_ui(['BigText', 'RichText', "Confirm"], ["About [MacroTool]", "MacroTool is developed by Felix M, and licensed under the CC-BY-SA 4.0 license. The complete source code is available on GitHub.", "OK"], none)
			get_tree().root.add_child(n)
