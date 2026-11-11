extends Node3D


const FREQUENCY := 0.2


var timer: float = FREQUENCY


@onready var wall_ray: RayCast3D = $WallRay


func _process(delta: float) -> void:
	timer -= delta
	if timer > 0:
		return
	
	timer = FREQUENCY
	for mutant in Mutant.all:
		if mutant.can_be_stunned() and PlayerCharacter.instance.is_in_light_range(mutant.global_position):
			if not Upgrades.is_unlocked_id("LIGHT_ROOM"):
				wall_ray.target_position = mutant.global_position - wall_ray.global_position
				wall_ray.force_raycast_update()
				if wall_ray.is_colliding():
					continue
			mutant.stunned.transition_to()
