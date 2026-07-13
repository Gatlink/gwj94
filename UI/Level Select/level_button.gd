@tool
class_name LevelButton
extends TextureButton


@export var data: LevelData:
	set(value):
		data = value
		disabled = not data.unlocked
