class_name Room
extends Node3D


@onready var doors: Dictionary[int, Node3D] = {
	Level.NORTH: $Ground/DoorNorth,
	Level.EAST: $Ground/DoorEast,
	Level.SOUTH: $Ground/DoorSouth,
	Level.WEST: $Ground/DoorWest
}

@onready var door_colliders: Dictionary[int, CollisionShape3D] = {
	Level.NORTH: $CollisionWalls/DoorNorth,
	Level.EAST: $CollisionWalls/DoorEast,
	Level.SOUTH: $CollisionWalls/DoorSouth,
	Level.WEST: $CollisionWalls/DoorWest
}


func open_door(side: int) -> void:
	doors[side].visible = true
	door_colliders[side].disabled = true
