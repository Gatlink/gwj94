class_name PlayerShoot
extends PlayerState


const KICKBACK: float = 0.2
const MUTANT_KEEP_TARGET: float = 5.0


var tween: Tween


func enter() -> void:
	super()
	player.weapon.set_active(true)
	player.dummy.shoot()
	player.dummy.flash.play()
	Camera.shake(0.2, 0.3)
	HUD.instance.refresh_ammo(player.weapon)
	
	var rooms: Array[int] = Level.current.get_connected_rooms(player.room_idx, player.weapon.loudness)
	for mutant in Mutant.all:
		if rooms.has(mutant.room_idx):
			mutant.force_target_pos(player.global_position, MUTANT_KEEP_TARGET)
			mutant.chase.transition_to()
	
	tween = create_tween()
	tween.tween_property(player.dummy, "position", player.dummy.basis.z * KICKBACK, 0.1).set_ease(Tween.EASE_OUT)
	tween.tween_callback(player.weapon.set_active.bind(false))
	tween.tween_property(player.dummy, "position", Vector3.ZERO, 0.2)
	tween.tween_callback(player.stand.transition_to)
	tween.play()


func exit() -> void:
	super()
	if is_instance_valid(tween) and tween.is_running():
		tween.kill()
	
	# Make sure values a reinitialized in case the player is moved out of this
	# state before the end of the tween
	player.weapon.set_active(false)
	player.dummy.position = Vector3.ZERO
