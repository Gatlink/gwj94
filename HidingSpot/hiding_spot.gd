class_name HidingSpot
extends Interactable


func on_interact() -> void:
	if player.state is PlayerHide:
		return
	
	var pc := player # As move_to disables collisions, player needs to be kept
	pc.move_to.transition_to(global_position)
	
	await player.move_to.target_reached
	
	pc.hide_state.transition_to()
