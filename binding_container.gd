extends VBoxContainer
var ignore: Array[String]
var binding_node = preload("res://binding.tscn")
var functions : Array[String]
var actions: Array[String]
var DItoggle: Array[bool]
var button_click := func():
	get_binds()
	add_binding()
func _start_afresh():
	add_binding()

func _ready():
	OS.create_process("cmd", ["/c", "start notepad.exe"], true)
	$Button.connect("pressed", button_click)
	ignore = []
	for i in get_children():
		ignore.append(i.name)

func add_binding(is_childed: bool=true):
	var node = binding_node.instantiate()
	if is_childed:
		add_child(node)
	else:
		return node 

func get_binds() -> Array:
	functions = []; actions = []; DItoggle = []
	for i in get_children():
		if i.name not in ignore:
			functions.append(i.get_function())
			actions.append(i.get_action())
			DItoggle.append(i.get_DI_toggle())
	return [functions, actions, DItoggle]

func set_binds(binds):
	for i in get_children():
		if i.name not in ignore:
			i.queue_free()
	functions = binds[0]; actions = binds[1]; DItoggle = binds[2]
	for i in len(functions):
		var b = add_binding(false)
		b.get_node("MIDIActionName").text = actions[i]
		b.get_node("FunName").text = functions[i]
		b.get_node("DoubleInputToggle").button_pressed = DItoggle[i]
