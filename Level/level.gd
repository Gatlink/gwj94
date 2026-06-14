class_name Level
extends Node3D


const ROOM := preload("uid://bjf4c3v0ja6vl")
const ROOM_SIZE := 10
# MUST BE ODD
const ROOM_ROW := 3
const ROOM_COL := 3
const CLOSE_DOOR_COUNT := 3


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


var rooms: Array[Room] = []


func _ready() -> void:
	var col_offset := -(ROOM_ROW - 1) * ROOM_SIZE / 2.0
	var row_offset := ROOM_SIZE / 2.0
	for row in ROOM_ROW:
		for col in ROOM_COL:
			var pos := Vector3(col * ROOM_SIZE + col_offset, 0, row * ROOM_SIZE + row_offset)
			var room := ROOM.instantiate() as Room
			add_child(room)
			room.position = pos
			rooms.append(room)
			
			if col == 0:
				room.close_door(WEST)
			elif col == ROOM_COL - 1:
				room.close_door(EAST)
			if row == 0 and not col == floori(ROOM_COL / 2.0):
				room.close_door(NORTH)
			elif row == ROOM_ROW - 1:
				room.close_door(SOUTH)
