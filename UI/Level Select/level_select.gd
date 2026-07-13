extends Control


@onready var level_name: Label = $LevelName


var first_button: LevelButton


func _ready() -> void:
	level_name.hide()
	for child in get_children():
		var level_button := child as LevelButton
		if level_button != null:
			if first_button == null:
				first_button = level_button
			
			level_button.mouse_entered.connect(on_mouse_enter.bind(level_button))
			level_button.mouse_exited.connect(on_mouse_exit)
			level_button.pressed.connect(on_pressed.bind(level_button))
			level_button.focus_entered.connect(on_mouse_enter.bind(level_button))
			level_button.focus_exited.connect(on_mouse_exit)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file(Game.TITLE_SCREEN)
	else:
		var focused := get_viewport().gui_get_focus_owner()
		if focused == null:
			if not PlayerInput.use_kb_mouse and PlayerInput.move_dir:
				first_button.grab_focus()
		elif PlayerInput.use_kb_mouse:
			focused.release_focus()


func on_mouse_enter(level_button: LevelButton) -> void:
	level_name.show()
	level_name.text = level_button.data.name


func on_mouse_exit() -> void:
	level_name.hide()


func on_pressed(level_button: LevelButton) -> void:
	Game.level = level_button.data
	get_tree().change_scene_to_packed(level_button.data.scene)
