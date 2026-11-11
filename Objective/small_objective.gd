class_name SmallObjective
extends Objective


const CHECK_FREQUENCY := 0.5


var timer := CHECK_FREQUENCY


@onready var particles: CPUParticles3D = $Particles


func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0:
		particles.emitting = PlayerCharacter.instance.is_in_light_range(global_position)
		timer = CHECK_FREQUENCY
