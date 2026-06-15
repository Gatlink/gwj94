class_name MutantChase
extends MutantState


const SPEED := 4.8


func enter() -> void:
	super()
	mutant.dummy.walk(SPEED)
	mutant.current_speed = SPEED
	mutant.navigation.max_speed = SPEED


func _process(_delta: float) -> void:
	if mutant.strike.target != null:
		mutant.strike.transition_to()
	elif not mutant.has_target:
		mutant.back_to_start.transition_to()


func _physics_process(_delta: float) -> void:
	if mutant.navigation.is_navigation_finished() and mutant.has_target:
		mutant.navigation.target_position = mutant.target_pos
