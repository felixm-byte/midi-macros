extends Control
func set_error_text(t: String) -> void:
	$Panel/VBoxContainer/Label2.text = t
func _ready():
	await get_tree().create_timer(5.0).timeout
	queue_free()
