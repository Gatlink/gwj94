class_name Room
extends Node3D


var bounds: Rect2


@onready var model: RoomModel = $RoomModel
@onready var mutant_spawn_points: Node3D = $MutantSpawnPoints
@onready var objective_spawn_points: Node3D = $ObjectiveSpawnPoints
@onready var door_colliders: Dictionary[int, CollisionShape3D] = {
	Level.NORTH: $CollisionWalls/DoorNorth,
	Level.EAST: $CollisionWalls/DoorEast,
	Level.SOUTH: $CollisionWalls/DoorSouth,
	Level.WEST: $CollisionWalls/DoorWest
}


func update_bounds() -> void:
	var size := Vector2.ONE * Level.ROOM_SIZE
	var pos := Vector2(global_position.x, global_position.z) - size * 0.5
	bounds = Rect2(pos, size)


func open_door(side: int) -> void:
	model.doors[side].visible = false
	door_colliders[side].disabled = true


func get_spawn_points() -> Array[Vector3]:
	var points: Array[Vector3] = []
	for child in mutant_spawn_points.get_children():
		var marker := child as Marker3D
		if marker != null:
			points.append(marker.global_position)
	
	return points


func get_open_doors_count() -> int:
	var count := 0
	for collider in door_colliders.values():
		if collider.disabled:
			count += 1
	
	return count


# Return a mask of directions with an open door
func get_open_doors() -> int:
	var result: int = 0
	for direction in door_colliders:
		if is_door_open(direction):
			result |= direction
	return result


func is_door_open(side: int) -> bool:
	return door_colliders[side].disabled
