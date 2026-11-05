extends Area3D


const FREQUENCY := 0.2
const STUN_IMMUNITY := 3.0


var timer: float = FREQUENCY
var mutants: Array[Mutant] = []
var immune: Array[Mutant] = []
var stunned: Dictionary[Mutant, float] = {}


@onready var wall_ray: RayCast3D = $WallRay


func _physics_process(delta: float) -> void:
	timer -= delta
	if timer > 0:
		return
	
	timer = FREQUENCY
	wall_ray.enabled = true
	var now := Time.get_ticks_msec() / 1000.0
	for mutant in mutants:
		if immune.has(mutant) or now - stunned.get(mutant, 0) < STUN_IMMUNITY:
			continue
		
		wall_ray.target_position = mutant.global_position - wall_ray.global_position
		wall_ray.force_raycast_update()
		if wall_ray.is_colliding():
			continue
		
		mutant.stunned.transition_to()
		immune.append(mutant)
		stunned[mutant] = now
	
	wall_ray.enabled = false


func _on_body_entered(body: Node3D) -> void:
	var mutant := body as Mutant
	if mutant != null:
		mutants.append(mutant)


func _on_body_exited(body: Node3D) -> void:
	if body is Mutant:
		mutants.erase(body)
		immune.erase(body)
