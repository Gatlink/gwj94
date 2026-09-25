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


@onready var target_ray: RayCast3D = $TargetRay
@onready var ammo: int = ammo_max


var timer: float


func _process(delta: float) -> void:
	if timer > 0:
		timer -= delta
		
		if timer <= 0 and ammo_max > 0 and ammo == 0:
			ammo = ammo_max


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
		timer = cooldown if ammo > 0 else reload_duration
	else:
		timer = cooldown
	
	if sfx_strike != null:
		sfx_strike.play()
	
	target_ray.enabled = true
	super(true)


func apply_damage(health_manager : HealthManager) -> void:
	target_ray.target_position = health_manager.global_position - global_position
	target_ray.force_raycast_update()
	if not target_ray.is_colliding():
		super(health_manager)


func can_use() -> bool:
	return (ammo_max <= 0 or ammo > 0) and timer <= 0
