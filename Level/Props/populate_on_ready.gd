class_name PopulateOnReady
extends Node3D


@export var models: Array[PackedScene]
@export var unique: bool
@export_range(0, 1, 0.05) var empty_chance: float


func _ready() -> void:
	if randf() < empty_chance:
		return
	
	var children := get_children()
	children.shuffle()
	models.shuffle()
	for child in children:
		var mark := child as Marker3D
		if mark == null:
			continue
		
		var instance := models.pop_front().instantiate() as Node3D
		if instance != null:
			add_child(instance)
			instance.transform = mark.transform
			
			if unique:
				break
