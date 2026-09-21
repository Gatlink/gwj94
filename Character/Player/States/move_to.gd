class_name PlayerMoveTo
extends PlayerState


signal target_reached


var target: Vector3


func enter() -> void:
	super()
	if player.global_position != target:
		player.look_at(target)
	player.dummy.walk(player.get_speed())
	player.collision.disabled = true
	
	var duration := player.global_position.distance_to(target) / player.get_speed()
	var tween := create_tween()
	tween.tween_property(player, "global_position", target, duration)
	tween.tween_callback(target_reached.emit)
	tween.play()


func exit() -> void:
	super()
	player.collision.disabled = false


func transition_to(...params: Array) -> void:
	target = params.front() as Vector3
	super()
