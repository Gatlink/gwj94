@tool
class_name LevelButton
extends TextureButton


@export var data: LevelData:
	set(value):
		data = value
		disabled = not data.unlocked
		focus_mode = Control.FOCUS_NONE if disabled else Control.FOCUS_ALL
