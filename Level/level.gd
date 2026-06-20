class_name Level
extends Node3D


const OBJECTIVE = preload("uid://c888bstisw35")
const MUTANT := preload("uid://bmefsumjb7wc2")
const ROOM_SIZE := 10
# MUST BE ODD
const ROOM_ROW := 3
const ROOM_COL := 3
const CLOSE_DOOR_COUNT := 3
const LIFT_ROOM_IDX := floori(ROOM_COL / 2.0)


enum {
	NORTH = 0b0001,
	EAST = 0b0010,
	SOUTH = 0b0100,
	WEST = 0b1000
}


static func get_opposite(side: int) -> int:
	match side:
		NORTH: return SOUTH
		EAST: return WEST
		SOUTH: return NORTH
		WEST: return EAST
	
	return -1


static var directions: Array[int] = [NORTH, EAST, SOUTH, WEST]


@export var room_scenes: Array[PackedScene]


@onready var navigation_region: NavigationRegion3D = $NavigationRegion3D


var rooms: Array[Room] = []
var room_dist: Array[int] = []
var obj_room_idx: int = -1


func _ready() -> void:
	var col_offset := -(ROOM_ROW - 1) * ROOM_SIZE / 2.0
	var row_offset := ROOM_SIZE / 2.0
	for row in ROOM_ROW:
		for col in ROOM_COL:
			var pos := Vector3(col * ROOM_SIZE + col_offset, 0, row * ROOM_SIZE + row_offset)
			var room := room_scenes.pick_random().instantiate() as Room
			navigation_region.add_child(room)
			room.position = pos
			rooms.append(room)
			room_dist.append(-1)
	
	# Open door to lift
	rooms[LIFT_ROOM_IDX].open_door(NORTH)
	room_dist[LIFT_ROOM_IDX] = 0
	
	var unconnected_rooms_idx: Array[int] = []
	for i in rooms.size():
		if i != LIFT_ROOM_IDX:
			unconnected_rooms_idx.append(i)
	
	while unconnected_rooms_idx.size() > 0:
		var room_idx: int = unconnected_rooms_idx.pick_random()
		connect_room(room_idx, unconnected_rooms_idx)
	
	navigation_region.bake_navigation_mesh()
	
	place_objective()
	place_mutants()


func connect_room(room_idx: int, unconnected_idx: Array[int]) -> void:
	var path: Dictionary[int, int] = {}
	if not create_path(room_idx, path, unconnected_idx):
		return
	
	var distance := path.size()
	var last_idx := get_neighbor_index(path.keys().back(), path.values().back())
	distance += room_dist[last_idx]
	
	for idx in path:
		var side := path[idx]
		var neighbor := get_neighbor_index(idx, side)
		unconnected_idx.erase(idx)
		unconnected_idx.erase(neighbor)
		rooms[idx].open_door(path[idx])
		rooms[neighbor].open_door(get_opposite(side))
		room_dist[idx] = distance
		distance -= 1


func create_path(room_idx: int, path: Dictionary[int, int], unconnected_idx: Array[int]) -> bool:
	# Path leads to a connected room: success
	if not unconnected_idx.has(room_idx):
		return true
	
	# Get valid neighbors: room exists and not already visited
	var valid_neighbors: Dictionary[int, int] = {}
	var sides := directions.duplicate()
	sides.shuffle()
	for side in sides:
		var neighbor_idx := get_neighbor_index(room_idx, side)
		if neighbor_idx != -1 and not path.has(neighbor_idx):
			valid_neighbors[side] = neighbor_idx
	
	# Continue path through valid neighbors
	for side in valid_neighbors:
		path[room_idx] = side
		if create_path(valid_neighbors[side], path, unconnected_idx):
			return true
	
	# No valid path found
	path.erase(room_idx)
	return false


func place_objective() -> void:
	var objective_dh := DecisionHelper.new(range(rooms.size()))
	objective_dh.remove(func (i: int): return i == LIFT_ROOM_IDX)
	objective_dh.score(func (i: int): return room_dist[i])
	objective_dh.score(func (i: int): return -rooms[i].get_open_doors_count() * 0.25)
	objective_dh.score(func (_i: int): return randf())
	
	obj_room_idx = objective_dh.get_best()
	var room: Room = rooms[obj_room_idx]
	var marker: Node3D = room.objective_spawn_points.get_children().pick_random()
	var objective := OBJECTIVE.instantiate() as Node3D
	add_child(objective)
	objective.global_position = marker.global_position


func place_mutants() -> void:
	var spawn_points: Array[Vector3] = []
	var points_to_room: Dictionary[Vector3, int] = {}
	for room_idx in rooms.size():
		var points := rooms[room_idx].get_spawn_points()
		spawn_points.append_array(points)
		for point in points:
			points_to_room[point] = room_idx
	
	var already_spawned: Array[int] = []
	for i in Game.get_mutant_count():
		if spawn_points.is_empty():
			break
		
		var spawn_dh := DecisionHelper.new(spawn_points)
		spawn_dh.remove(func (point: Vector3): return points_to_room[point] == LIFT_ROOM_IDX)
		spawn_dh.score(func (point: Vector3): return rooms[points_to_room[point]].get_open_doors_count())
		spawn_dh.score(func (point: Vector3): return 2 if points_to_room[point] == obj_room_idx else 0)
		spawn_dh.score(func (point: Vector3): return -3 if already_spawned.has(points_to_room[point]) else 0)
		spawn_dh.score(func (_point: Vector3): return randf())
		
		var pos: Vector3 = spawn_dh.get_best()
		spawn_points.erase(pos)
		already_spawned.append(points_to_room[pos])
		
		var instance := MUTANT.instantiate() as Mutant
		instance.position = pos
		add_child(instance)


func get_room_coord(room_idx: int) -> Vector2:
	@warning_ignore("integer_division")
	return Vector2(room_idx % ROOM_COL, room_idx / ROOM_COL)


func get_neighbor_index(idx: int, side: int) -> int:
	if side == NORTH and idx >= ROOM_COL:
		return idx - ROOM_COL
	if side == SOUTH and idx < rooms.size() - ROOM_COL:
		return idx + ROOM_COL
	if side == WEST and idx % ROOM_COL > 0:
		return idx - 1
	if side == EAST and idx % ROOM_COL < ROOM_COL - 1:
		return idx + 1
	
	return -1
