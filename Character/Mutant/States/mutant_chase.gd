class_name MutantChase
extends MutantState


const SPEED := 4.8
const PATH_REFRESH_RATE := 0.2


var timer: float


func enter() -> void:
	super()
	mutant.dummy.walk(SPEED)
	mutant.current_speed = SPEED
	mutant.navigation.max_speed = SPEED
	mutant.navigation.target_position = mutant.global_position
	timer = PATH_REFRESH_RATE


func _process(_delta: float) -> void:
	if mutant.strike.target != null:
		mutant.strike.transition_to()
	elif not mutant.is_player_in_range():
		mutant.back_to_start.transition_to()
	
	#timer -= delta
	#if timer <= 0:
		#mutant.navigation.target_position = mutant.player.global_position
		#timer = PATH_REFRESH_RATE


func _physics_process(_delta: float) -> void:
	if mutant.navigation.is_navigation_finished():
		mutant.navigation.target_position = mutant.player.global_position
