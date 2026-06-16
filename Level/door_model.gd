@tool
class_name DoorModel
extends Node3D


@export_enum("North", "East", "South", "West") var direction: int:
	set(value):
		direction = value
		if is_instance_valid(mesh):
			global_rotation.y = deg_to_rad(-90 * value)


@onready var mesh: MeshInstance3D = $Door_003


func set_material(material: StandardMaterial3D) -> void:
	mesh.set("surface_material_override/0", material)
