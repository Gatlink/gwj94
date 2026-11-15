class_name AboveHeadUI
extends Control


enum {
	NONE = 0b0,
	SHELL = 0b1,
	DASH = 0b10,
	DODGE = 0b100,
	WEAPON = 0b1000,
	ALL = 0b1111,
}


const JOYPAD_COLOR := Color("549937")
const JOYPAD_TEXTURE = preload("uid://1jqfn24h1gr7")
const KEYBOARD_COLOR := Color.WHITE
const KEYBOARD_TEXTURE = preload("uid://cmg4y7p1qgp4y")


static var _instance: AboveHeadUI


var _visible_elements: int = NONE


@onready var _interaction: HBoxContainer = $VBoxContainer/Interaction
@onready var _interaction_name = $VBoxContainer/Interaction/Name
@onready var _input: TextureRect = $VBoxContainer/Interaction/Input
@onready var _all: HBoxContainer = $VBoxContainer/All
@onready var _shell: HBoxContainer = $VBoxContainer/All/Shell
@onready var _shell_progress: TextureProgressBar = $VBoxContainer/All/Shell/ShellProgress
@onready var _dash: HBoxContainer = $VBoxContainer/All/Dash
@onready var _dash_progress: TextureProgressBar = $VBoxContainer/All/Dash/DashProgress
@onready var _dodge: HBoxContainer = $VBoxContainer/All/Dodge
@onready var _dodge_progress: TextureProgressBar = $VBoxContainer/All/Dodge/DodgeProgress
@onready var _weapon: HBoxContainer = $VBoxContainer/All/Weapon
@onready var _weapon_icon: TextureRect = $VBoxContainer/All/Weapon/WeaponIcon
@onready var _weapon_progress: TextureProgressBar = $VBoxContainer/All/Weapon/WeaponProgress


static func show_element(element: int) -> void:
	if _instance != null:
		_instance._show_element(element)


static func hide_element(element: int) -> void:
	if _instance != null:
		_instance._hide_element(element)


static func hide_all() -> void:
	hide_element(ALL)
	_instance._interaction.hide()


func _ready() -> void:
	_instance = self
	for child in _all.get_children():
		child.hide()


func _process(_delta: float) -> void:
	if PlayerCharacter.instance.can_interact():
		var use_keyboard: bool = PlayerInput.use_kb_mouse
		_input.modulate = KEYBOARD_COLOR if use_keyboard else JOYPAD_COLOR
		_input.texture = KEYBOARD_TEXTURE if use_keyboard else JOYPAD_TEXTURE
		_interaction_name.text = PlayerCharacter.instance.get_interaction_name()
		_interaction.show()
	else:
		_interaction.hide()
	
	if _shell.visible:
		var hide_state: PlayerHideShell = PlayerCharacter.instance.hide_shell
		_shell_progress.value = hide_state.get_timer_ratio()
	
	if _dash.visible:
		var dash: PlayerDash = PlayerCharacter.instance.dash
		_dash_progress.value = dash.get_cooldown_ratio()
	
	if _dodge.visible:
		_dodge_progress.value = PlayerCharacter.instance.get_dodge_cooldown_ratio()
	
	if _weapon.visible:
		_weapon_progress.value = PlayerCharacter.instance.weapon.get_reload_progress()
	
	if _visible_elements > 0 or _input.visible:
		var pos_3d: Vector3 = PlayerCharacter.instance.above_ui_pos.global_position
		position = get_viewport().get_camera_3d().unproject_position(pos_3d)


func _exit_tree() -> void:
	_instance = null


func _show_element(element: int) -> void:
	_visible_elements |= element
	_refresh_elements()


func _hide_element(element: int) -> void:
	_visible_elements &= ~element
	_refresh_elements()


func _refresh_elements() -> void:
	_shell.visible = _visible_elements & SHELL
	_dash.visible = _visible_elements & DASH
	_dodge.visible = _visible_elements & DODGE
	_weapon.visible = _visible_elements & WEAPON
	
	if _weapon.visible and _weapon_icon.texture == null:
		_weapon_icon.texture = PlayerCharacter.instance.weapon.ammo_pip
