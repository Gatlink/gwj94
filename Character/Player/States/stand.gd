class_name PlayerStand
extends PlayerState


func _process(_delta: float) -> void:
	var look_forward := -player.basis.z
	var look_dir := Vector2(look_forward.x, look_forward.z)
	var walk_forward := player.velocity.normalized()
	var walk_dir := Vector2(walk_forward.x, walk_forward.z)
	walk_dir = walk_dir.rotated(look_dir.angle_to(Vector2.DOWN))
	player.dummy.set_stand_parameter(walk_dir, player.velocity.length() if player.velocity else 1.0)


func _physics_process(_delta: float) -> void:
	player.move()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shell") and Upgrades.is_unlocked_id("SHELL"):
		player.hide_shell.transition_to()
	elif event.is_action_pressed("shoot") \
			and player.weapon != null \
			and player.weapon.can_use():
		player.shoot.transition_to()
	elif event.is_action_pressed("dash") \
			and Upgrades.is_unlocked_id("SPEED_DASH") \
			and player.dash.can_dash():
		player.dash.transition_to()
