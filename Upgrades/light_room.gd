extends Node3D


var current_room := -1


func _process(_delta: float) -> void:
	if current_room != PlayerCharacter.instance.room_idx:
		current_room = PlayerCharacter.instance.room_idx
		global_position = Level.current.rooms[current_room].global_position
