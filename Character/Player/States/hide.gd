class_name PlayerHide
extends PlayerState


func enter() -> void:
	super()
	player.collision.disabled = true
	player.graph.scale.y = 0.5
	player.dummy.idle()


func exit() -> void:
	super()
	player.collision.disabled = false
	player.graph.scale.y = 1.0


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		player.stand.transition_to()
