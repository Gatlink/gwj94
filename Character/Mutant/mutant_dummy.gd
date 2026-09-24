class_name MutantDummy
extends CharacterDummy


const IDLE_SPEED := 0.5


@export var walk_speed_factor := 1.0


@onready var animation: AnimationPlayer = $AnimationPlayer


func idle() -> void:
	animation.play("Idle", 0.2, IDLE_SPEED)


func walk(speed: float) -> void:
	animation.play("Walk" if speed <= MutantIdle.SPEED else "Chase", 0.2, speed * walk_speed_factor)


func hit() -> void:
	animation.stop()
	animation.play("Attack", 0.2, 2.0)
