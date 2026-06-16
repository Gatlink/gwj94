@tool
class_name RoomModel
extends Node3D


enum RoomType {
	OFFICE,
	LAB
}


const materials_floor: Dictionary[RoomType, StandardMaterial3D] = {
	RoomType.OFFICE: preload("uid://b0f3j0jenm2bx"),
	RoomType.LAB: preload("uid://0ma783jbfquw")
}

const materials_wall: Dictionary[RoomType, StandardMaterial3D] = {
	RoomType.OFFICE: preload("uid://c8s6xroo6e5t1"),
	RoomType.LAB: preload("uid://dpr81kysn57du")
}

const materials_outer: Dictionary[RoomType, StandardMaterial3D] = {
	RoomType.OFFICE: preload("uid://cmwkmwtlhhi8x"),
	RoomType.LAB: preload("uid://b8vkh1yfb5bfg")
}

const materials_door: Dictionary[RoomType, StandardMaterial3D] = {
	RoomType.OFFICE: preload("uid://hxxtfrd380p"),
	RoomType.LAB: preload("uid://4x1g22v20qb2")
}


@export var type: RoomType = RoomType.OFFICE:
	set(value):
		type = value
		update_materials()


@onready var mesh: MeshInstance3D = $Room
@onready var door_north: DoorModel = $DoorNorth
@onready var door_east: DoorModel = $DoorEast
@onready var door_south: DoorModel = $DoorSouth
@onready var door_west: DoorModel = $DoorWest
@onready var doors: Dictionary[int, DoorModel] = {
	Level.NORTH: door_north,
	Level.EAST: door_east,
	Level.SOUTH: door_south,
	Level.WEST: door_west
}


func update_materials() -> void:
	if not is_instance_valid(mesh):
		return
	
	mesh.set("surface_material_override/0", materials_floor[type])
	mesh.set("surface_material_override/1", materials_wall[type])
	mesh.set("surface_material_override/2", materials_outer[type])
	
	door_north.set_material(materials_door[type])
	door_east.set_material(materials_door[type])
	door_south.set_material(materials_door[type])
	door_west.set_material(materials_door[type])
