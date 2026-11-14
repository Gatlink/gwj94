@abstract
class_name Interactable
extends Area3D
## Must be monitorable and in layer Interactable to work properly


@export var action_name: String


func can_interact() -> bool:
	return true


@abstract func interact() -> void
