class_name CharacterDummy
extends Node3D


const PARAMETER_WALK := "parameters/Stand/blend_position"
const PARAMETER_SPEED := "parameters/Speed/scale"
const ANIM_SPEED_WALK_FACTOR := 0.8


@onready var animation: AnimationTree = $AnimationTree


func walk(speed: float) -> void:
	set_stand_parameter(Vector2.UP, speed * ANIM_SPEED_WALK_FACTOR)


func idle() -> void:
	set_stand_parameter(Vector2.ZERO)


func set_stand_parameter(direction: Vector2, speed := 1.0) -> void:
	animation.set(PARAMETER_WALK, direction)
	
	if direction:
		speed *= ANIM_SPEED_WALK_FACTOR
	
	animation.set(PARAMETER_SPEED, speed)
