@abstract
class_name CharacterState
extends Node


@onready var character := get_parent() as Character


func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	set_process_unhandled_input(false)


func enter() -> void:
	set_process(true)
	set_physics_process(true)
	set_process_unhandled_input(true)


func exit() -> void:
	set_process(false)
	set_physics_process(false)
	set_process_unhandled_input(false)


func transition_to(..._params: Array) -> void:
	character.state.exit()
	character.state = self
	enter()
