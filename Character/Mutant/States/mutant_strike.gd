class_name MutantStrike
extends MutantState


var target: PlayerCharacter


func enter() -> void:
	super()
	mutant.dummy.idle()
	mutant.graph.look_at(target.global_position)
	
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(mutant.graph, "scale", Vector3(1.2, 0.8, 1.2), 0.5)
	tween.tween_callback(hit)
	tween.tween_property(mutant.graph, "scale", Vector3(1, 1, 1), 0.25)
	tween.tween_callback(mutant.chase.transition_to)
	tween.play()


func hit() -> void:
	if mutant.hitbox.overlaps_body(PlayerCharacter.instance):
		PlayerCharacter.instance.die.transition_to()
		target = null
		mutant.range_shape.disabled = true


func _on_range_body_entered(body: Node3D) -> void:
	if body is PlayerCharacter:
		target = body


func _on_range_body_exited(body: Node3D) -> void:
	if body is PlayerCharacter and target == body:
		target = null
