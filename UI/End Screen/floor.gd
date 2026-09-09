class_name UIFloor
extends TextureRect


const FLOOR_CONTENT_LEFT := preload("uid://dt0k88cgcpryo")
const FLOOR_CONTENT_RIGHT := preload("uid://0h61ha38s7vl")
const HISTORY_UPGRADE := "upgrade:"
const HISTORY_DEATH := "death"
const HISTORY_MAIN_OBJECTIVE := "main_objective"
const HISTORY_OBJECTIVE := "objective"


@onready var content_anchor_left: Control = $ContentAnchorLeft
@onready var content_anchor_right: Control = $ContentAnchorRight
@onready var lit_windows: TextureRect = $LitWindows


func display_content_left(floor_idx: int) -> void:
	if not Game.floor_history.has(floor_idx):
		return
	
	var instance := FLOOR_CONTENT_LEFT.instantiate() as UIFloorContent
	content_anchor_left.add_child(instance)
	instance.set_content(Game.floor_history[floor_idx])


func display_content_right(floor_idx: int) -> void:
	if not Game.floor_history.has(floor_idx):
		return
	
	var instance := FLOOR_CONTENT_RIGHT.instantiate() as UIFloorContent
	content_anchor_right.add_child(instance)
	instance.set_content(Game.floor_history[floor_idx])


func light_windows() -> void:
	lit_windows.show()
