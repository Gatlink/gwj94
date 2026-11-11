class_name MutantStunned
extends MutantState


const DURATION: float = 2.0
const IMMUNITY: float = 3.0
const STUN_WEAKNESS: int = 1


var timer: float


func enter() -> void:
	super()
	timer = DURATION
	mutant.fx_stun.show()
	mutant.dummy.idle()
	mutant.navigation.target_position = mutant.global_position
	
	if Upgrades.is_unlocked_id("LIGHT_WEAK"):
		mutant.health_manager.damage_bonus += STUN_WEAKNESS


func exit() -> void:
	super()
	mutant.fx_stun.hide()
	mutant.stun_immunity = IMMUNITY
	
	if Upgrades.is_unlocked_id("LIGHT_WEAK"):
		mutant.health_manager.damage_bonus -= STUN_WEAKNESS


func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0:
		mutant.idle.transition_to(0.5)
