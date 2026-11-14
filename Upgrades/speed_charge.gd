extends Area3D


@onready var _shape: CollisionShape3D = $CollisionShape3D


func _process(_delta: float) -> void:
	_shape.disabled = not PlayerCharacter.instance.state is PlayerDash


func _on_body_entered(body: Node3D) -> void:
	var mutant := body as Mutant
	if mutant != null and mutant.can_be_stunned():
		mutant.stunned.transition_to()
