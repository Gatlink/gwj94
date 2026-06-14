@abstract
class_name CharacterDummy
extends Node3D


@abstract func walk(speed: float) -> void
@abstract func idle() -> void


func set_stand_parameter(_direction: Vector2, _speed := 1.0) -> void:
	pass
