class_name MutantIdle
extends MutantState


func enter() -> void:
	super()
	character.dummy.idle()
	character.velocity = Vector3.ZERO


func _process(_delta: float) -> void:
	if mutant.is_player_in_range:
		mutant.chase.transition_to()
