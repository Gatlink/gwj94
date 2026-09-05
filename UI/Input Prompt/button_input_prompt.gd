@tool
class_name ButtonInputPrompt
extends Node


const ACTION_PREFIX := "gamepad_ui_"
const ICONS: Dictionary[String, Texture2D] = {
	"A": preload("uid://bvmkarx440f6h"),
	"B": preload("uid://b22ctvw37sxbd"),
	"X": preload("uid://d140v37lxlq5u"),
	"Y": preload("uid://dctro5fpbpln3"),
	"Start": preload("uid://cnigihni62mwv")
}


@export_enum("A", "B", "X", "Y", "Start") var gamepad_button: String = "A"


@onready var button := get_parent() as Button


func _get_configuration_warnings() -> PackedStringArray:
	if not get_parent() is Button:
		return ["Parent must be a Button."]
	
	return []


func _ready() -> void:
	var event := InputEventAction.new()
	event.action = ACTION_PREFIX + gamepad_button.to_lower()
	event.pressed = true
	
	var shortcut := Shortcut.new()
	shortcut.events = [event]
	button.shortcut = shortcut
	
	if Engine.is_editor_hint():
		set_process(false)


func _process(_delta: float) -> void:
	button.icon = ICONS[gamepad_button] if not PlayerInput.use_kb_mouse and not button.disabled else null
