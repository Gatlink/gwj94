class_name Level
extends Node3D


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


var rooms: Array[Room] = []


func _ready() -> void:
	var col_offset := -(ROOM_ROW - 1) * ROOM_SIZE / 2.0
	var row_offset := ROOM_SIZE / 2.0
	for row in ROOM_ROW:
		for col in ROOM_COL:
			var pos := Vector3(col * ROOM_SIZE + col_offset, 0, row * ROOM_SIZE + row_offset)
			var room := room_scenes.pick_random().instantiate() as Room
			add_child(room)
			room.position = pos
			rooms.append(room)
			
			# Open door to lift
			if row == 0 and col == LIFT_ROOM_IDX:
				room.open_door(NORTH)
	
	var unconnected_rooms_idx: Array[int] = []
	for i in rooms.size():
		if i != LIFT_ROOM_IDX:
			unconnected_rooms_idx.append(i)
	
	while unconnected_rooms_idx.size() > 0:
		var room_idx: int = unconnected_rooms_idx.pick_random()
		connect_room(room_idx, unconnected_rooms_idx)


func connect_room(room_idx: int, unconnected_rooms_idx: Array[int]) -> void:
	var visited_idx: Array[int] = []
	while unconnected_rooms_idx.has(room_idx):
		var coord := get_room_coord(room_idx)
		var sides := directions.duplicate()
		if coord.x == 0:
			sides.erase(WEST)
		elif coord.x == ROOM_COL - 1:
			sides.erase(EAST)
		if coord.y == 0:
			sides.erase(NORTH)
		elif coord.y == ROOM_ROW - 1:
			sides.erase(SOUTH)
		
		sides.shuffle()
		for side in sides:
			var next_idx := get_neighbor_index(room_idx, side)
			if next_idx != -1 and not visited_idx.has(next_idx):
				unconnected_rooms_idx.erase(room_idx)
				visited_idx.append(room_idx)
				rooms[room_idx].open_door(side)
				rooms[next_idx].open_door(get_opposite(side))
				room_idx = next_idx
				break


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
