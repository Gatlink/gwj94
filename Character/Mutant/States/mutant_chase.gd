class_name MutantChase
extends MutantState


const SPEED := 4.8


func enter() -> void:
	super()
	mutant.dummy.walk(SPEED)
	mutant.current_speed = SPEED
	mutant.navigation.max_speed = SPEED
	mutant.sfx_big_growl.play()
	mutant.navigation.target_position = mutant.target_pos


func _process(_delta: float) -> void:
	if mutant.strike.target != null and not mutant.strike.target.is_dead():
		mutant.strike.transition_to()
	elif not mutant.has_target:
		mutant.idle.transition_to(0.5)
		mutant.display_question()


func _physics_process(_delta: float) -> void:
	if mutant.navigation.is_navigation_finished() and mutant.has_target:
		mutant.navigation.target_position = mutant.target_pos
