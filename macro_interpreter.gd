extends Node
class_name MacroInterpreter
var lua: LuaAPI = LuaAPI.new()
var macro: Macro
var function_enabled: Array[bool] = []
func start(m: Macro):
	macro = m
	lua.bind_libraries(["base", "table", "string"])
	lua.push_variant('alert', alert)
	var err: LuaError = lua.do_string(m.lua_script)
	for i in macro.functions:
		function_enabled.append(true)

var alert := func (x: String, y: String):
	OS.alert(x, y)

var call_function := func(n: String):
	var e = lua.call_function(n, [])
	if e is LuaError:
		alert.call("ERROR %d: %s" % [e.type, e.message], "Error in interpreted Lua macro")
func action_occured(ref: String):
	for i in range(len(macro.actions)):
		if ref == macro.actions[i]:
			if macro.DItoggle[i] == false:
				call_function.call(macro.functions[i])
			elif function_enabled[i] == true:
				function_enabled[i] = false
				call_function.call(macro.functions[i])
				await get_tree().create_timer(2).timeout
				function_enabled[i] = true

