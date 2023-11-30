extends Node
#A simplified string format with only the data needed for comparison is better
func convert_to_standard(event: InputEventMIDI) -> String:
	var text: String = "MIDI: "
	text += ("ch:" + str(event.channel) + " ")
	text += ("msg:" + str(event.message) + " ")
	text += ("pitch:" + str(event.pitch) + " ")
	return text
var opened := false
func open_device():
	if not opened:
		OS.open_midi_inputs()
		opened = true
