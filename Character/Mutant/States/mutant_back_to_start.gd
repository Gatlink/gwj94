class_name MutantBackToStart
extends MutantState


const SPEED := 2.0


var start_pos: Vector3


func _ready() -> void:
	super()
	start_pos = mutant.global_position


func enter() -> void:
	super()
	
	mutant.dummy.walk(SPEED)
	mutant.current_speed = SPEED
	mutant.navigation.max_speed = SPEED
	mutant.navigation.target_position = start_pos


func _process(_delta: float) -> void:
	if mutant.has_target:
		mutant.navigation.target_position = mutant.global_position
		mutant.chase.transition_to()
	elif mutant.navigation.is_target_reached():
		mutant.idle.transition_to()
