class_name Character
extends CharacterBody3D


@export var state: CharacterState
@export var dummy: CharacterDummy


@onready var graph: Node3D = $Graph


func _ready() -> void:
	state.enter()


func update_stand_parameters() -> void:
	var look_forward := -graph.basis.z
	var look_dir := Vector2(look_forward.x, look_forward.z)
	var walk_forward := velocity.normalized()
	var walk_dir := Vector2(walk_forward.x, walk_forward.z)
	walk_dir = walk_dir.rotated(look_dir.angle_to(Vector2.DOWN))
	dummy.set_stand_parameter(walk_dir, velocity.length() if velocity else 1.0)
