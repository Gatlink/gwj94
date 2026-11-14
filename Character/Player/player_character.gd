class_name PlayerCharacter
extends Character


const SPEED := 5.0
const SPEED_BOOSTED := SPEED * 1.2
const LIGHT_RANGE_BONUS := 2.0
const WEAPON_SHOTGUN := preload("uid://c0ln62oshwty4")
const LIGHT_STUN := preload("uid://do4psnfi756tu")
const LIGHT_ROOM := preload("uid://cbd6b526axmhr")
const LIFE_STUN_RANGE := 5.0


static var instance: PlayerCharacter


var was_hit: bool
var weapon: WeaponBase
var current_room_idx: int = -1


@onready var collision: CollisionShape3D = $PhysicsCollision
@onready var light: OmniLight3D = $LightHolder/Light
@onready var sfx_objective: AudioStreamPlayer3D = $SFXObjective
@onready var above_ui_pos: Marker3D = $AboveUIPos

#region STATES
@onready var no_input: PlayerNoInput = $NoInput
@onready var stand: PlayerStand = $Stand
@onready var move_to: PlayerMoveTo = $MoveTo
@onready var hide_state: PlayerHide = $Hide
@onready var hide_shell: PlayerHideShell = $HideShell
@onready var die: PlayerDie = $Die
@onready var shoot: PlayerShoot = $Shoot
@onready var bump: PlayerBump = $Bump
@onready var dash: PlayerDash = $Dash
#endregion

func _ready() -> void:
	instance = self
	if Upgrades.is_unlocked_id("LIGHT_ROOM"):
		Level.current.add_child(LIGHT_ROOM.instantiate())
		light.queue_free()
	elif Upgrades.is_unlocked_id("LIGHT"):
		light.omni_range += LIGHT_RANGE_BONUS
	if Upgrades.is_unlocked_id("SHOTGUN"):
		weapon = WEAPON_SHOTGUN.instantiate() as WeaponBase
		add_child(weapon)
	if Upgrades.is_unlocked_id("LIGHT_STUN"):
		add_child(LIGHT_STUN.instantiate())
	if Upgrades.is_unlocked_id("LIFE_PROTECTION"):
		health_manager.damage_cap = 1
	
	super()
	
	dummy.play_sfx = true
	health_manager.max_hp = Game.max_health
	health_manager.current_hp = Game.current_health
	health_manager.health_changed.connect(update_health)
	
	HUD.instance.refresh_health(health_manager)
	HUD.instance.refresh_ammo(weapon)


func _exit_tree() -> void:
	instance = null


func _process(_delta: float) -> void:
	if Level.current == null:
		return
	
	var current_room := Level.current.get_room_idx(global_position)
	if current_room != current_room_idx:
		current_room_idx = current_room


func get_speed() -> float:
	return SPEED_BOOSTED if Upgrades.is_unlocked_id("SPEED") else SPEED


func move(speed_factor: float = 1.0, lock_look_at: bool = false) -> void:
	# Movement
	var speed: float = get_speed() * speed_factor
	if PlayerInput.move_dir:
		velocity.x = PlayerInput.move_dir.x * speed
		velocity.z = PlayerInput.move_dir.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()
	
	# Look At
	if not lock_look_at and PlayerInput.look_dir != Vector3.ZERO:
		look_toward(PlayerInput.look_dir)
	elif PlayerInput.move_dir != Vector3.ZERO:
		look_toward(PlayerInput.move_dir)


func hit(bump_force: Vector3) -> void:
	bump.bump = bump_force
	bump.transition_to()
	
	if Upgrades.is_unlocked_id("LIFE_STUN"):
		for mutant in Mutant.all:
			if mutant.can_be_stunned() and mutant.global_position.distance_squared_to(global_position) <= LIFE_STUN_RANGE ** 2:
				mutant.stunned.transition_to()
	
	if is_dead():
		return
	
	if Upgrades.is_unlocked_id("SHELL_EMERGENCY"):
		hide_shell.transition_to()
		hide_shell.emergency_refill()


func kill() -> void:
	if Upgrades.is_unlocked_id("LIFE_REBIRTH") and not was_hit:
		was_hit = true
		health_manager.heal(3)
	else:
		die.transition_to()


func update_health(current: int, _max: int) -> void:
	Game.current_health = current


func is_in_light_range(pos: Vector3) -> bool:
	if Upgrades.is_unlocked_id("LIGHT_ROOM"):
		return Level.current.get_room_idx(pos) == current_room_idx
	return global_position.distance_squared_to(pos) <= light.omni_range ** 2
