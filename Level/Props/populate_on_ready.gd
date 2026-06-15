class_name PopulateOnReady
extends Node3D


@export var models: Array[PackedScene]


func _ready() -> void:
	models.shuffle()
	for child in get_children():
		var mark := child as Marker3D
		if mark != null:
			var instance := models.pop_front().instantiate() as Node3D
			if instance != null:
				add_child(instance)
				instance.transform = mark.transform
