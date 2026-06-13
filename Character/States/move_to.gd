class_name CharacterMoveTo
extends CharacterState


signal target_reached


var target: Vector3


func enter() -> void:
	super()
	character.graph.look_at(target)
	
	var duration := character.global_position.distance_to(target) / character.stand.SPEED
	var tween := create_tween()
	tween.tween_property(character, "global_position", target, duration)
	tween.tween_callback(target_reached.emit)
	tween.play()


func transition_to(...params: Array) -> void:
	target = params.front() as Vector3
	super()
