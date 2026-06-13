class_name HidingSpot
extends Interactable


func on_interact() -> void:
	if player.state is PlayerHide:
		return
	
	player.move_to.transition_to(global_position)
	
	await player.move_to.target_reached
	
	player.hide_state.transition_to()
