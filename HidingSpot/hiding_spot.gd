class_name HidingSpot
extends Interactable


func on_interact() -> void:
	PlayerCharacter.instance.move_to.transition_to(global_position)
	
	await PlayerCharacter.instance.move_to.target_reached
	
	# hide
