class_name HealthManager
extends Area3D


signal health_changed(current: int, max: int)


@export_range(0, 100) var max_hp: int = 10
@export_range(0, 10) var invulnerability_duration: float


@onready var current_hp: int = max_hp


var timer: float
var damage_bonus: int
var damage_cap: int = -1


func _process(delta : float) -> void:
	timer -= delta
	
	if timer <= 0:
		set_process(false)


func is_dead() -> bool:
	return current_hp <= 0


func hit(damage : int, bump: Vector3) -> void:
	if timer > 0:
		return
	
	if current_hp <= 0:
		return
	
	damage += damage_bonus
	if damage_cap >= 0:
		damage = mini(damage_cap, damage)
	current_hp -= damage
	health_changed.emit(current_hp, max_hp)
	
	if owner.has_method("hit"):
		owner.hit(bump)
	
	if is_dead():
		if owner.has_method("kill"):
			owner.kill()
		else:
			owner.queue_free()
	
	if invulnerability_duration > 0:
		timer = invulnerability_duration
		set_process(true)


func set_can_be_touched(can_be_touched : bool) -> void:
	for child in get_children():
		var shape := child as CollisionShape3D
		if shape != null:
			shape.disabled = not can_be_touched


func heal(amount: int) -> void:
	current_hp = mini(current_hp + amount, max_hp)
	health_changed.emit(current_hp, max_hp)
