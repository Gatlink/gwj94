extends Control


const BUTTON_CONSOLE: Texture2D = preload("uid://1jqfn24h1gr7")
const BUTTON_KEYBOARD = preload("uid://cmg4y7p1qgp4y")


@onready var button: Button = $VBoxContainer/Button


func _process(_delta: float) -> void:
	button.icon = BUTTON_KEYBOARD if PlayerInput.use_kb_mouse else BUTTON_CONSOLE


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
