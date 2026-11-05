class_name MutantStunned
extends MutantState


const DURATION: float = 2.0


var timer: float


func enter() -> void:
	super()
	timer = DURATION
	mutant.fx_stun.show()
	mutant.dummy.idle()
	mutant.navigation.target_position = mutant.global_position


func exit() -> void:
	super()
	mutant.fx_stun.hide()


func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0:
		mutant.idle.transition_to(0.5)
