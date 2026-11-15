class_name WeaponBase
extends DamageSource


## Number of shots before the weapon needs to be reloaded,
## 0 or less means the weapon doesn't use ammo
@export var ammo_max: int
## Time between two shots
@export var cooldown: float
## Time to complete a reload, 0 or less means the weapon cannot be reloaded
@export var reload_duration: float
@export var sfx_strike: AudioStreamPlayer3D 
@export var ammo_pip: Texture2D
## When fired, mutants in connected rooms up to this value away will hear.
## -1 means the weapon is silent
@export var loudness: int = -1


var timer: float


@onready var target_ray: RayCast3D = $TargetRay
@onready var ammo: int = ammo_max


func _process(delta: float) -> void:
	if timer > 0:
		timer -= delta
		if timer <= 0 and ammo == 0:
			_complete_reload()


func set_active(is_active : bool) -> void:
	if not is_active:
		super(false)
		return
	
	if timer > 0:
		return
	
	if ammo_max > 0:
		if ammo <= 0:
			return
		ammo -= 1
		if ammo > 0:
			_start_cooldown()
		else:
			_start_reloading()
	else:
		timer = cooldown
	
	if sfx_strike != null:
		sfx_strike.play()
	
	super(true)


func apply_damage(health_manager : HealthManager) -> void:
	target_ray.target_position = health_manager.global_position - global_position
	target_ray.force_raycast_update()
	if not target_ray.is_colliding():
		super(health_manager)


func can_use() -> bool:
	return (ammo_max <= 0 or ammo > 0) and timer <= 0


func get_reload_progress() -> float:
	return 1.0 - timer / reload_duration


func _start_reloading() -> void:
	if reload_duration > 0:
		timer = reload_duration
		AboveHeadUI.show_element(AboveHeadUI.WEAPON)


func _complete_reload() -> void:
	if reload_duration > 0:
		ammo = ammo_max
		AboveHeadUI.hide_element(AboveHeadUI.WEAPON)
		HUD.instance.refresh_ammo(PlayerCharacter.instance.weapon)


func _start_cooldown() -> void:
	timer = cooldown
