class_name MutantIdle
extends MutantState


const SPEED := 1.5
const ROAM_MIN_TIME := 4.0
const ROAM_MAX_TIME := 6.0
const GROWL_MIN_TIME := 3.0
const GROWL_MAX_TIME := 10.0
const FRAME_START_MOVE := 0.4
const FRAME_STOP_MOVE := 1.5


var roam_timer: float
var growl_timer: float


func enter() -> void:
	super()
	character.dummy.idle()
	character.velocity = Vector3.ZERO
	mutant.navigation.target_position = mutant.global_position
	reset_roam_timer()
	reset_growl_timer()


func _process(delta: float) -> void:
	if mutant.has_target:
		mutant.chase.transition_to()
		return
	
	growl_timer -= delta
	if growl_timer <= 0:
		reset_growl_timer()
		mutant.sfx_low_growl.play()
	
	if mutant.navigation.is_navigation_finished():
		roam_timer -= delta
		if roam_timer <= 0:
			var map_rid := mutant.navigation.get_navigation_map()
			var dest := NavigationServer3D.map_get_random_point(map_rid, 1, false)
			mutant.navigation.target_position = dest
			mutant.current_speed = SPEED
			mutant.dummy.walk(SPEED)
			reset_roam_timer()
		else:
			mutant.dummy.idle()
	else:
		var dummy := mutant.dummy as MutantDummy
		var anim_pos := dummy.animation.current_animation_position
		mutant.current_speed = SPEED if anim_pos >= FRAME_START_MOVE and anim_pos <= FRAME_STOP_MOVE else 0.0


func transition_to(...params: Array) -> void:
	super(params)
	
	if params[0] is float:
		roam_timer *= params[0]


func reset_roam_timer() -> void:
	roam_timer = randf_range(ROAM_MIN_TIME, ROAM_MAX_TIME)


func reset_growl_timer() -> void:
	growl_timer = randf_range(GROWL_MIN_TIME, GROWL_MAX_TIME)
