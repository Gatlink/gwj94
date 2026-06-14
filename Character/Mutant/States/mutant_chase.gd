class_name MutantChase
extends MutantState


const SPEED := 4.8


func enter() -> void:
	super()
	mutant.dummy.walk(SPEED)


func _process(_delta: float) -> void:
	if mutant.strike.target != null:
		mutant.strike.transition_to()
	elif not mutant.is_player_in_range():
		mutant.back_to_start.transition_to()


func _physics_process(_delta: float) -> void:
	var player_pos := PlayerCharacter.instance.global_position
	mutant.velocity = mutant.global_position.direction_to(player_pos) * SPEED
	mutant.graph.look_at(player_pos)
	mutant.move_and_slide()
