class_name PlayerShoot
extends PlayerState


const KICKBACK := 0.2


var targets: Array[Mutant] = []
var tween: Tween


func enter() -> void:
	super()
	player.dummy.idle()
	player.hitbox.disabled = false
	
	tween = create_tween()
	tween.tween_property(player.dummy, "position", -player.dummy.basis.z * KICKBACK, 0.1).set_ease(Tween.EASE_OUT)
	tween.tween_callback(hit)
	tween.tween_property(player.dummy, "position", Vector3.ZERO, 0.2)
	tween.tween_callback(player.stand.transition_to)
	tween.play()


func exit() -> void:
	super()
	if is_instance_valid(tween) and tween.is_running():
		tween.kill()
	
	player.hitbox.disabled = true
	player.shoot_ray.enabled = false
	targets.clear()


func _on_hit_box_body_entered(body: Node3D) -> void:
	var mutant := body as Mutant
	if mutant != null:
		targets.append(mutant)


func _on_hit_box_body_exited(body: Node3D) -> void:
	var mutant := body as Mutant
	if mutant != null:
		targets.erase(mutant)


func hit() -> void:
	player.shoot_ray.enabled = true
	targets.sort_custom(func (a: Mutant, b: Mutant):
		return a.global_position.distance_squared_to(player.global_position) < b.global_position.distance_squared_to(player.global_position)
	)
	for target in targets:
		player.shoot_ray.target_position = target.global_position - player.global_position
		player.shoot_ray.force_raycast_update()
		if player.shoot_ray.is_colliding() and player.shoot_ray.get_collider() is Mutant:
			target.die()
			await get_tree().physics_frame
