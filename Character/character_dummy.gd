class_name CharacterDummy
extends Node3D


const ANIM_SPEED_WALK_FACTOR := 0.8


@onready var animation: AnimationPlayer = $AnimationPlayer


func walk(speed: float) -> void:
	animation.play("Walk", -1, speed * ANIM_SPEED_WALK_FACTOR)


func idle() -> void:
	animation.play("Idle")
