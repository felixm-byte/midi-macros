extends HBoxContainer
signal binary_callback

func _on_option_1_pressed():
	emit_signal("binary_callback", 1)


func _on_option_2_pressed():
	emit_signal("binary_callback", 2)
