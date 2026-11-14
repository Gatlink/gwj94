class_name HidingSpot
extends Interactable


func _ready() -> void:
	priority = 10


func interact() -> void:
	var pc := PlayerCharacter.instance # As move_to disables collisions, player needs to be kept
	pc.move_to.transition_to(global_position)
	
	await pc.move_to.target_reached
	
	pc.hide_state.transition_to()
