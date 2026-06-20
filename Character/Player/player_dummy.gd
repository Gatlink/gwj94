class_name PlayerDummy
extends CharacterDummy


const PARAMETER_WALK := "parameters/Stand/blend_position"
const PARAMETER_WALK_FAST := "parameters/StandFast/blend_position"
const PARAMETER_WALK_SHOTGUN := "parameters/StandShotgun/blend_position"
const PARAMETER_SPEED := "parameters/Speed/scale"
const PARAMETER_STATE := "parameters/State/transition_request"
const PARAMETER_SHOOT := "parameters/Shoot/request"
const ANIM_SPEED_WALK_FACTOR := 0.8


@onready var animation: AnimationTree = $AnimationTree
@onready var shotgun: MeshInstance3D = $ShotGun


var parameter_walk := PARAMETER_WALK


func _ready() -> void:
	if not Game.is_locked(Game.UPGRADES.SHOTGUN):
		parameter_walk = PARAMETER_WALK_SHOTGUN
		animation.set(PARAMETER_STATE, "shotgun")
		shotgun.show()
	elif not Game.is_locked(Game.UPGRADES.SPEED):
		parameter_walk = PARAMETER_WALK_FAST
		animation.set(PARAMETER_STATE, "speed")
	else:
		animation.set(PARAMETER_STATE, "empty_hands")


func walk(speed: float) -> void:
	set_stand_parameter(Vector2.UP, speed * ANIM_SPEED_WALK_FACTOR)


func idle() -> void:
	set_stand_parameter(Vector2.ZERO)


func set_stand_parameter(direction: Vector2, speed := 1.0) -> void:
	animation.set(parameter_walk, direction)
	
	if direction:
		speed *= ANIM_SPEED_WALK_FACTOR
	
	animation.set(PARAMETER_SPEED, speed)


func shoot() -> void:
	animation.set(PARAMETER_SHOOT, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
