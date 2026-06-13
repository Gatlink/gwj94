class_name CharacterStand
extends CharacterState


const SPEED := 5.0


func _physics_process(_delta: float) -> void:
	# Movement
	if PlayerInput.move_dir:
		character.velocity.x = PlayerInput.move_dir.x * SPEED
		character.velocity.z = PlayerInput.move_dir.z * SPEED
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, SPEED)
		character.velocity.z = move_toward(character.velocity.z, 0, SPEED)

	character.move_and_slide()
	
	# Look At
	if PlayerInput.look_dir:
		character.graph.look_at(character.global_position + PlayerInput.look_dir)
	elif PlayerInput.move_dir:
		character.graph.look_at(character.global_position + PlayerInput.move_dir)
