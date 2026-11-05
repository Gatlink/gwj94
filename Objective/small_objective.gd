class_name SmallObjective
extends Objective


@onready var particles: CPUParticles3D = $Particles


func _on_reveal_area_body_entered(_body: Node3D) -> void:
	particles.emitting = true


func _on_reveal_area_body_exited(_body: Node3D) -> void:
	particles.emitting = false
