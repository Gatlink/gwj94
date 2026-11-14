class_name PlayerHide
extends PlayerState


func enter() -> void:
	super()
	player.collision.disabled = true
	player.dummy.idle()
	player.dummy.armature.hide()
	player.dummy.shell.show()
	AboveHeadUI.show_element(AboveHeadUI.UIElement.INPUT)


func exit() -> void:
	super()
	player.collision.disabled = false
	player.dummy.shell.hide()
	player.dummy.armature.show()
	AboveHeadUI.hide_element(AboveHeadUI.UIElement.INPUT)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		player.stand.transition_to()
