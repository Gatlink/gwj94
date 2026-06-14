class_name MutantDummy
extends CharacterDummy


@export var walk_speed_factor := 1.0


@onready var animation: AnimationPlayer = $AnimationPlayer


func idle() -> void:
	animation.play("Idle")


func walk(speed: float) -> void:
	animation.play("Walk" if speed <= MutantBackToStart.SPEED else "Chase", 0.2) #, speed * walk_speed_factor)


func hit() -> void:
	animation.play("Attack_2", 0.2, 2.0)
