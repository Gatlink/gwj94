class_name MutantStrike
extends MutantState


const END_DELAY := 0.5


var target: PlayerCharacter
var timer: float
var dummy: MutantDummy


func enter() -> void:
	super()
	timer = END_DELAY
	mutant.look_at(target.global_position)
	mutant.navigation.target_position = mutant.global_position
	
	dummy = mutant.dummy as MutantDummy
	dummy.hit()
	mutant.hitbox.set_active(true)


func exit() -> void:
	mutant.hitbox.set_active(false)


func _process(delta: float) -> void:
	if dummy.animation.is_playing():
		return
	
	timer -= delta
	if timer <= 0:
		mutant.chase.transition_to()


func _on_range_body_entered(body: Node3D) -> void:
	if body is PlayerCharacter:
		target = body


func _on_range_body_exited(body: Node3D) -> void:
	if body is PlayerCharacter and target == body:
		target = null
