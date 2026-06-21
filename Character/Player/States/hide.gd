class_name PlayerHide
extends PlayerState


func enter() -> void:
	super()
	player.collision.disabled = true
	player.dummy.idle()
	player.dummy.armature.hide()
	player.dummy.shell.show()
	player.input_prompt.show()


func exit() -> void:
	super()
	player.collision.disabled = false
	player.dummy.shell.hide()
	player.dummy.armature.show()
	player.input_prompt.hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		player.stand.transition_to()
