class_name MutantChase
extends MutantState


const SPEED := 5.1


func enter() -> void:
	super()
	mutant.dummy.walk()


func _process(_delta: float) -> void:
	if not mutant.is_player_in_range:
		mutant.idle.transition_to()


func _physics_process(_delta: float) -> void:
	var player_pos := PlayerCharacter.instance.global_position
	mutant.velocity = mutant.global_position.direction_to(player_pos) * SPEED
	mutant.graph.look_at(player_pos)
	mutant.move_and_slide()
