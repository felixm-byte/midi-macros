extends PanelContainer
@export var nodes: Array[Node] #= [$MarginContainer/$MarginContainer/VBoxContaineroxContainer/BigText, $MarginContainer/$MarginContainer/VBoxContaineroxContainer/LittleText, $MarginContainer/$MarginContainer/VBoxContaineroxContainer/EnterText, $MarginContainer/$MarginContainer/VBoxContaineroxContainer/BinarySelection, $MarginContainer/$MarginContainer/VBoxContaineroxContainer/Confirm, $MarginContainer/$MarginContainer/VBoxContaineroxContainer/RichText]
var c: Callable
func _generate_ui(elements: Array, text: Array, callback: Callable):
	c = callback
	for i in len(elements):
		match elements[i]:
			"BigText":
				var node = nodes[0].duplicate()
				node.text = text[i]
				$MarginContainer/VBoxContainer.add_child(node)
			"LittleText":
				var node = nodes[1].duplicate()
				node.text = text[i]
				$MarginContainer/VBoxContainer.add_child(node)
			"EnterText":
				var node = nodes[2].duplicate()
				node.placeholder_text = text[i]
				$MarginContainer/VBoxContainer.add_child(node)
			"BinarySelection":
				var node = nodes[3].duplicate()
				if text[i] is Array[String]:
					for n in len(text[i]): # For Binary selection, text is an array of 2 strings 
						node.get_node("Option" + str(n+1)).text = text[i][n]
				$MarginContainer/VBoxContainer.add_child(node)
				node.connect('binary_callback', binary_response)
			"Confirm":
				var node = nodes[4].duplicate()
				node.text = text[i]
				$MarginContainer/VBoxContainer.add_child(node)
			"RichText":
				var node = nodes[5].duplicate()
				node.text = text[i]
				$MarginContainer/VBoxContainer.add_child(node)
	for i in nodes:
		i.visible = false

func single_callback():
	c.call()
	queue_free()
func binary_response(number:int):
	c.call(number)
	queue_free()
