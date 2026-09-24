class_name PlayerCharacter
extends Character


const SPEED := 5.0
const SPEED_BOOSTED := SPEED * 1.2
const LIGHT_RANGE_BONUS := 2.0
const WEAPON_SHOTGUN := preload("uid://c0ln62oshwty4")


static var instance: PlayerCharacter


@onready var input_prompt: InputPrompt = $InputPrompt
@onready var collision: CollisionShape3D = $PhysicsCollision
@onready var light: OmniLight3D = $LightHolder/Light
@onready var sfx_objective: AudioStreamPlayer3D = $SFXObjective
# STATES
@onready var no_input: PlayerNoInput = $NoInput
@onready var stand: PlayerStand = $Stand
@onready var move_to: PlayerMoveTo = $MoveTo
@onready var hide_state: PlayerHide = $Hide
@onready var die: PlayerDie = $Die
@onready var shoot: PlayerShoot = $Shoot
@onready var bump: PlayerBump = $PlayerBump


var was_hit: bool
var weapon: WeaponBase


func _ready() -> void:
	instance = self
	if Upgrades.is_unlocked_id("LIGHT"):
		light.omni_range += LIGHT_RANGE_BONUS
	if Upgrades.is_unlocked_id("SHOTGUN"):
		weapon = WEAPON_SHOTGUN.instantiate() as WeaponBase
		add_child(weapon)
	
	super()
	
	dummy.play_sfx = true


func _exit_tree() -> void:
	instance = null


func get_speed() -> float:
	return SPEED_BOOSTED if Upgrades.is_unlocked_id("SPEED") else SPEED


func hit(bump_force: Vector3) -> void:
	bump.bump = bump_force
	bump.transition_to()


func kill() -> void:
	if Upgrades.is_unlocked_id("LIFE") and not was_hit:
		was_hit = true
		hide_state.transition_to()
	else:
		die.transition_to()
