class_name PlayerStand
extends PlayerState


func _process(_delta: float) -> void:
	player.update_stand_parameters()


func _physics_process(_delta: float) -> void:
	# Movement
	if PlayerInput.move_dir:
		character.velocity.x = PlayerInput.move_dir.x * player.get_speed()
		character.velocity.z = PlayerInput.move_dir.z * player.get_speed()
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, player.get_speed())
		character.velocity.z = move_toward(character.velocity.z, 0, player.get_speed())

	character.move_and_slide()
	
	# Look At
	if PlayerInput.look_dir:
		character.graph.look_at(character.global_position + PlayerInput.look_dir)
	elif PlayerInput.move_dir:
		character.graph.look_at(character.global_position + PlayerInput.move_dir)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shell") and not Game.is_locked(Game.UPGRADES.SHELL):
		player.hide_state.transition_to()
	elif event.is_action_pressed("shoot") and not Game.is_locked(Game.UPGRADES.SHOTGUN) and player.can_shoot():
		player.shoot.transition_to()
