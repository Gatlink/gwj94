class_name Room
extends Node3D


@onready var doors: Dictionary[int, Node3D] = {
	Level.NORTH: $DoorNorth,
	Level.EAST: $DoorEast,
	Level.SOUTH: $DoorSouth,
	Level.WEST: $DoorWest
}

@onready var door_colliders: Dictionary[int, CollisionShape3D] = {
	Level.NORTH: $CollisionWalls/DoorNorth,
	Level.EAST: $CollisionWalls/DoorEast,
	Level.SOUTH: $CollisionWalls/DoorSouth,
	Level.WEST: $CollisionWalls/DoorWest
}

@onready var mutant_spawn_points: Node3D = $MutantSpawnPoints
@onready var objective_spawn_points: Node3D = $ObjectiveSpawnPoints


func open_door(side: int) -> void:
	doors[side].visible = false
	door_colliders[side].disabled = true


func get_spawn_points() -> Array[Vector3]:
	var points: Array[Vector3] = []
	for child in mutant_spawn_points.get_children():
		var marker := child as Marker3D
		if marker != null:
			points.append(marker.global_position)
	
	return points
