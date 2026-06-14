class_name MutantDummy
extends CharacterDummy


@export var walk_speed_factor := 1.0


@onready var animation: AnimationPlayer = $AnimationPlayer


func idle() -> void:
	animation.play("Idle")


func walk(speed: float) -> void:
	animation.play("Walk", -1, speed * walk_speed_factor)
