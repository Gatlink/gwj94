class_name LevelButton
extends TextureButton


var data: LevelData:
	set(value):
		data = value
		disabled = not Levels.is_available[data]
		focus_mode = Control.FOCUS_NONE if disabled else Control.FOCUS_ALL


func _on_pressed() -> void:
	Game.start_level(data)


func _on_mouse_entered() -> void:
	if not disabled:
		grab_focus()


func _on_mouse_exited() -> void:
	if not disabled:
		release_focus()
