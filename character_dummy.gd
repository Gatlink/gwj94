class_name CharacterDummy
extends Node3D


const ANIM_SPEED_WALK := 4.0


@onready var animation: AnimationPlayer = $AnimationPlayer


func walk() -> void:
	animation.play("Walk", -1, ANIM_SPEED_WALK)


func idle() -> void:
	animation.play("Idle")
