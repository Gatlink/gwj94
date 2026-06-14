class_name TileSlot
extends Marker3D


const TILE := preload("uid://bjf4c3v0ja6vl")


@export_flags("North", "East", "South", "West") var open_sides: int


func _ready() -> void:
	var instance := TILE.instantiate() as Tile
	add_child(instance)
