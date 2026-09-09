extends Control


const LEVEL_BUTTON := preload("uid://dhdvxan6sqk3i")


@onready var level_name: Label = $LevelName
@onready var levels: HBoxContainer = $Levels


var first_button: LevelButton


func _ready() -> void:
	level_name.hide()
	for level in Levels.all:
		var button := LEVEL_BUTTON.instantiate() as LevelButton
		levels.add_child(button)
		button.data = level
		
		button.mouse_entered.connect(button.grab_focus)
		button.mouse_exited.connect(button.release_focus)
		
		if first_button == null:
			first_button = button
	
	first_button.grab_focus()


func _process(_delta: float) -> void:
	var button := get_viewport().gui_get_focus_owner() as LevelButton
	if button != null:
		level_name.text = button.data.name
		level_name.show()
	else:
		level_name.hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file(Game.TITLE_SCREEN)
		return
	
	var focused := get_viewport().gui_get_focus_owner()
	if focused == null:
		if not PlayerInput.use_kb_mouse and PlayerInput.move_dir:
			first_button.grab_focus()
	elif PlayerInput.use_kb_mouse:
		focused.release_focus()
