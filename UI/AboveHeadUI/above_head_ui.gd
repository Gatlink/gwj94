class_name AboveHeadUI
extends Control


enum {
	NONE = 0b0,
	SHELL = 0b1,
	INPUT = 0b10,
	DASH = 0b100,
	DODGE = 0b1000,
	ALL = 0b1111,
}


const JOYPAD_COLOR := Color("549937")
const JOYPAD_TEXTURE = preload("uid://1jqfn24h1gr7")
const KEYBOARD_COLOR := Color.WHITE
const KEYBOARD_TEXTURE = preload("uid://cmg4y7p1qgp4y")


static var _instance: AboveHeadUI


var _visible_elements: int = NONE


@onready var _input: TextureRect = $VBoxContainer/Input
@onready var _all: HBoxContainer = $VBoxContainer/All
@onready var _shell: HBoxContainer = $VBoxContainer/All/Shell
@onready var _shell_progress: TextureProgressBar = $VBoxContainer/All/Shell/ShellProgress
@onready var _dash: HBoxContainer = $VBoxContainer/All/Dash
@onready var _dash_progress: TextureProgressBar = $VBoxContainer/All/Dash/DashProgress
@onready var _dodge: HBoxContainer = $VBoxContainer/All/Dodge
@onready var _dodge_progress: TextureProgressBar = $VBoxContainer/All/Dodge/DodgeProgress


static func show_element(element: int) -> void:
	if _instance != null:
		_instance._show_element(element)


static func hide_element(element: int) -> void:
	if _instance != null:
		_instance._hide_element(element)


static func hide_all() -> void:
	hide_element(ALL)


func _ready() -> void:
	_instance = self
	set_process(false)
	hide()
	for child in _all.get_children():
		child.hide()


func _process(_delta: float) -> void:
	var pos_3d: Vector3 = PlayerCharacter.instance.above_ui_pos.global_position
	position = get_viewport().get_camera_3d().unproject_position(pos_3d)
	
	if _visible_elements & INPUT:
		var use_keyboard: bool = PlayerInput.use_kb_mouse
		_input.modulate = KEYBOARD_COLOR if use_keyboard else JOYPAD_COLOR
		_input.texture = KEYBOARD_TEXTURE if use_keyboard else JOYPAD_TEXTURE
	
	if _visible_elements & SHELL:
		var hide_state: PlayerHideShell = PlayerCharacter.instance.hide_shell
		_shell_progress.value = hide_state.get_timer_ratio()
	
	if _visible_elements & DASH:
		var dash: PlayerDash = PlayerCharacter.instance.dash
		_dash_progress.value = dash.get_cooldown_ratio()
	
	if _visible_elements & DODGE:
		_dodge_progress.value = PlayerCharacter.instance.get_dodge_cooldown_ratio()


func _exit_tree() -> void:
	_instance = null


func _show_element(element: int) -> void:
	_visible_elements |= element
	set_process(true)
	_refresh_elements()
	
	if not visible:
		show()


func _hide_element(element: int) -> void:
	_visible_elements &= ~element
	_refresh_elements()
	if _visible_elements == NONE:
		set_process(false)
		hide()


func _refresh_elements() -> void:
	_shell.visible = _visible_elements & SHELL
	_input.visible = _visible_elements & INPUT
	_dash.visible = _visible_elements & DASH
	_dodge.visible = _visible_elements & DODGE
