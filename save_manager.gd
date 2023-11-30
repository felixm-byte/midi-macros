extends VBoxContainer
var macro: Macro
func _ready():
	$HBoxContainer/Button.connect("pressed", _save)

func _save():
	if $CodeEdit.text == null:
		return
	macro = Macro.new()
	var binds = $ScrollContainer/BindingContainer.get_binds()
	macro.functions = binds[0]
	macro.actions = binds[1]
	macro.DItoggle = binds[2]
	macro.lua_script = $CodeEdit.text
	var dir = DirAccess.open("user://")
	dir.make_dir("macros")
	ResourceSaver.save(macro, "user://macros/" + $HBoxContainer/FileName.text + ".luacro.tres")

func get_macro() -> Macro:
	macro = Macro.new()
	var binds = $ScrollContainer/BindingContainer.get_binds()
	macro.functions = binds[0]
	macro.actions = binds[1]
	macro.DItoggle = binds[2]
	macro.lua_script = $CodeEdit.text
	return macro

func set_state(state: Macro) -> void:
	$CodeEdit.text = state.lua_script if state.lua_script not in [null, ""] else ""
	var binds = [state.functions, state.actions, state.DItoggle] if state.functions != null else []
	$ScrollContainer/BindingContainer.set_binds(binds)
	macro = state
