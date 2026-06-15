class_name RotateOnReady
extends Node


@export_range(0, 180) var angle: float


func _ready() -> void:
	var parent := get_parent() as Node3D
	if parent != null:
		parent.rotation.y += deg_to_rad((2 * randf() - 1) * angle)
