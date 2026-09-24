class_name PlayerShoot
extends PlayerState


const KICKBACK := 0.2


var tween: Tween


func enter() -> void:
	super()
	player.weapon.set_active(true)
	player.dummy.shoot()
	player.dummy.flash.play()
	Camera.shake(0.2, 0.3)
	
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
