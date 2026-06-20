class_name MutantIdle
extends MutantState


const GROWL_MIN_TIME := 3.0
const GROWL_MAX_TIME := 10.0


var growl_timer: float


func enter() -> void:
	super()
	character.dummy.idle()
	character.velocity = Vector3.ZERO
	reset_growl_timer()


func _process(delta: float) -> void:
	if mutant.has_target:
		mutant.chase.transition_to()
	else:
		growl_timer -= delta
		if growl_timer <= 0:
			reset_growl_timer()
			mutant.sfx_low_growl.play()


func reset_growl_timer() -> void:
	growl_timer = randf_range(GROWL_MIN_TIME, GROWL_MAX_TIME)
