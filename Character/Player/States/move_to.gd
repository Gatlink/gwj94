class_name PlayerMoveTo
extends PlayerState


signal target_reached


var target: Vector3


func enter() -> void:
	super()
	player.graph.look_at(target)
	
	var duration := player.global_position.distance_to(target) / player.stand.SPEED
	var tween := create_tween()
	tween.tween_property(player, "global_position", target, duration)
	tween.tween_callback(target_reached.emit)
	tween.play()


func transition_to(...params: Array) -> void:
	target = params.front() as Vector3
	super()
