extends HBoxContainer
@onready var bind := get_node('Bind')
var listening := false
var function : String
var trigger : String
var start_listening := func():
	listening = true
	$Bind.text = "Binding Action"

func _ready():
	Utility.open_device()
	bind.pressed.connect(start_listening)

func _input(event):
	if listening:
		if event is InputEventMIDI:
			trigger = Utility.convert_to_standard(event)
			$MIDIActionName.text = trigger
			$Bind.text = "Rebind Action"
			listening = false
func handle_error(message: String):
	var e = load("res://error.tscn")
	e = e.instantiate()
	e.set_error_text(message)
	get_tree().root.add_child(e)
	
func get_action() -> String:
	if trigger != null:
		return trigger
	else:
		handle_error("Action not bound. Please ensure all actions are bound.")
		return "Action not assigned"

func get_function() -> String:
	function = $FunName.text
	if function in [null, ""]:
		handle_error("Action not assigned")
		return "Function not assigned"
	else:
		return function

func get_DI_toggle() -> bool:
	return $DoubleInputToggle.button_pressed
