class_name Tile
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


func _ready() -> void:
	var slot := get_parent() as TileSlot
	close_doors(slot.open_sides)


func close_doors(open_side_flags: int) -> void:
	if open_side_flags & Level.NORTH == 0:
		close_door(Level.NORTH)
	
	if open_side_flags & Level.EAST == 0:
		close_door(Level.EAST)
	
	if open_side_flags & Level.SOUTH == 0:
		close_door(Level.SOUTH)
	
	if open_side_flags & Level.WEST == 0:
		close_door(Level.WEST)


func close_door(side: int) -> void:
	doors[side].visible = false
	door_colliders[side].disabled = false
