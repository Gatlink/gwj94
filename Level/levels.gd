extends Node


@export var all: Array[LevelData]


var is_available: Dictionary[LevelData, bool]


func _ready() -> void:
	for level in all:
		is_available[level] = level.starts_available
