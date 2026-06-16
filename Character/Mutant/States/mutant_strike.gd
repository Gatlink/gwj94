class_name MutantStrike
extends MutantState


var target: PlayerCharacter


func enter() -> void:
	super()
	mutant.graph.look_at(target.global_position)
	mutant.navigation.target_position = mutant.global_position
	
	var dummy := mutant.dummy as MutantDummy
	dummy.hit()
	
	await dummy.animation.animation_finished
	
	if mutant.hitbox.overlaps_body(PlayerCharacter.instance):
		PlayerCharacter.instance.hurt()
		target = null
	
	await get_tree().create_timer(0.5).timeout
	
	mutant.chase.transition_to()


func _on_range_body_entered(body: Node3D) -> void:
	if body is PlayerCharacter:
		target = body


func _on_range_body_exited(body: Node3D) -> void:
	if body is PlayerCharacter and target == body:
		target = null
