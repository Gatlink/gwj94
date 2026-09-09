class_name PlayerCharacter
extends Character


const SPEED := 5.0
const SPEED_BOOSTED := SPEED * 1.2
const LIGHT_RANGE_BONUS := 2.0
const SHOTGUN_COOLDOWN := 1.5


static var instance: PlayerCharacter


@onready var input_prompt: InputPrompt = $InputPrompt
@onready var collision: CollisionShape3D = $PhysicsCollision
@onready var hitbox: CollisionShape3D = $HitBox/CollisionShape3D
@onready var light: OmniLight3D = $LightHolder/Light
@onready var shoot_ray: RayCast3D = $ShootRay
@onready var no_input: PlayerNoInput = $NoInput
@onready var stand: PlayerStand = $Stand
@onready var move_to: PlayerMoveTo = $MoveTo
@onready var hide_state: PlayerHide = $Hide
@onready var die: PlayerDie = $Die
@onready var shoot: PlayerShoot = $Shoot
@onready var sfx_shotgun: AudioStreamPlayer3D = $SFXShotgun
@onready var sfx_objective: AudioStreamPlayer3D = $SFXObjective


var was_hit: bool
var shotgun_timer: float


func _ready() -> void:
	instance = self
	if Upgrades.is_unlocked_id("LIGHT"):
		light.omni_range += LIGHT_RANGE_BONUS
	
	super()
	
	dummy.play_sfx = true


func _exit_tree() -> void:
	instance = null


func _process(delta: float) -> void:
	if shotgun_timer >= 0:
		shotgun_timer -= delta


func get_speed() -> float:
	return SPEED_BOOSTED if Upgrades.is_unlocked_id("SPEED") else SPEED


func hurt() -> void:
	if Upgrades.is_unlocked_id("LIFE") and not was_hit:
		was_hit = true
		hide_state.transition_to()
	else:
		die.transition_to()


func can_shoot() -> bool:
	return shotgun_timer <= 0
